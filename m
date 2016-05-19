From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Thu, 19 May 2016 22:52:34 +0300
Subject: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
In-Reply-To: <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
Message-ID: <573E1982.7090402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 05/19/2016 08:00 AM, Andy Gross wrote:
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

Is this change depends on some another patchset, I cannot find
idle-states dt node on mainline nor linux-next ?

>  			CPU_SPC: spc {
> -				compatible = "arm,idle-state";
> +				compatible = "qcom,idle-state-spc", "arm,idle-state";
>  				arm,psci-suspend-param = <0x40000002>;
>  				entry-latency-us = <130>;
>  				exit-latency-us = <150>;
> 
