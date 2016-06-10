From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Jun 2016 16:48:57 +0100
Subject: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
In-Reply-To: <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
Message-ID: <20160610154857.GA6430@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+ Lorenzo]

On Thu, May 19, 2016 at 12:00:18AM -0500, Andy Gross wrote:
> This patch adds the qcom,idle-state-spc compatible to the SPC idle
> state.  This compatible indicates that the state is one which supports
> freeze.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 208af00..032e411 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -104,7 +104,7 @@
>  
>  		idle-states {
>  			CPU_SPC: spc {
> -				compatible = "arm,idle-state";
> +				compatible = "qcom,idle-state-spc", "arm,idle-state";
>  				arm,psci-suspend-param = <0x40000002>;
>  				entry-latency-us = <130>;
>  				exit-latency-us = <150>;

This looks suspicious.

This is a PSCI idle state, and we have a PSCI driver driven by the
generic ARM cpuidle driver.

Why do we need a qcom-specific compatible here?

Surely we should be able to use the idle code in a generic fashion to
driver suspend-to-idle?

Thank,
Mark.
