From: edubezval@gmail.com (Eduardo Valentin)
Date: Wed, 27 Apr 2016 17:03:47 -0700
Subject: [PATCH v5 11/11] arm64: dts: msm8996: Add thermal zones, tsens
 and qfprom nodes
In-Reply-To: <1460626319-14516-12-git-send-email-rnayak@codeaurora.org>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
 <1460626319-14516-12-git-send-email-rnayak@codeaurora.org>
Message-ID: <20160428000346.GE2590@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 03:01:59PM +0530, Rajendra Nayak wrote:
> Add thermal zones, tsens and qfprom nodes
> 
> Cc: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 92 +++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 0506fb8..4b36929 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -97,6 +97,92 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 3>;
> +
> +			trips {
> +				cpu_alert0: trip at 0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit0: trip at 1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};


cooling devices?
