From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 11 Jun 2015 17:47:34 +0100
Subject: [PATCHv2 7/7] arm64: dts: juno: describe PMUs separately
In-Reply-To: <1434041060-16378-8-git-send-email-mark.rutland@arm.com>
References: <1434041060-16378-1-git-send-email-mark.rutland@arm.com>
 <1434041060-16378-8-git-send-email-mark.rutland@arm.com>
Message-ID: <20150611164734.GK12807@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 05:44:20PM +0100, Mark Rutland wrote:
> The A57 and A53 PMUs in support different events, so describe them
> separately in the Juno dts files.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Thanks,
Liviu

> ---
>  arch/arm64/boot/dts/arm/juno-r1.dts | 18 +++++++++++-------
>  arch/arm64/boot/dts/arm/juno.dts    | 18 +++++++++++-------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> index c627511..734e127 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -91,17 +91,21 @@
>  		};
>  	};
>  
> -	pmu {
> -		compatible = "arm,armv8-pmuv3";
> +	pmu_a57 {
> +		compatible = "arm,cortex-a57-pmu";
>  		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&A57_0>,
> +				     <&A57_1>;
> +	};
> +
> +	pmu_a53 {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-affinity = <&A57_0>,
> -				     <&A57_1>,
> -				     <&A53_0>,
> +		interrupt-affinity = <&A53_0>,
>  				     <&A53_1>,
>  				     <&A53_2>,
>  				     <&A53_3>;
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index d7cbdd4..ffa05ae 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -91,17 +91,21 @@
>  		};
>  	};
>  
> -	pmu {
> -		compatible = "arm,armv8-pmuv3";
> +	pmu_a57 {
> +		compatible = "arm,cortex-a57-pmu";
>  		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&A57_0>,
> +				     <&A57_1>;
> +	};
> +
> +	pmu_a53 {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-affinity = <&A57_0>,
> -				     <&A57_1>,
> -				     <&A53_0>,
> +		interrupt-affinity = <&A53_0>,
>  				     <&A53_1>,
>  				     <&A53_2>,
>  				     <&A53_3>;
> -- 
> 1.9.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
