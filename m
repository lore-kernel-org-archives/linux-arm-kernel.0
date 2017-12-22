From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 22 Dec 2017 09:35:25 +0000
Subject: [PATCH v2] arm64: dts: hi3660: improve pmu description
In-Reply-To: <1510226303-20950-1-git-send-email-xuyiping@hisilicon.com>
References: <1510226303-20950-1-git-send-email-xuyiping@hisilicon.com>
Message-ID: <5A3CD1DD.1020302@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xu YiPing,

On 2017/11/9 11:18, Xu YiPing wrote:
> cortex-a73 pmu driver is supported now. hi3660 is 4*a73 + 4*a53, so it
> should use "cortex-a73-pmu" and "cortex-a53-pmu" instead of "armpmu-v3",
> then we can use the a73 and a53 events in perf tool directly.
> 
> Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>

Applied into hisilicon dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 13ae69f..f4882d3 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -203,21 +203,25 @@
>  					 IRQ_TYPE_LEVEL_HIGH)>;
>  	};
>  
> -	pmu {
> -		compatible = "arm,armv8-pmuv3";
> +	a53-pmu {
> +		compatible = "arm,cortex-a53-pmu";
>  		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-affinity = <&cpu0>,
>  				     <&cpu1>,
>  				     <&cpu2>,
> -				     <&cpu3>,
> -				     <&cpu4>,
> +				     <&cpu3>;
> +	};
> +
> +	a73-pmu {
> +		compatible = "arm,cortex-a73-pmu";
> +		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu4>,
>  				     <&cpu5>,
>  				     <&cpu6>,
>  				     <&cpu7>;
> 
