From: liviu@dudau.co.uk (Liviu Dudau)
Date: Thu, 8 Oct 2015 17:25:13 +0100
Subject: [PATCHv4 4/6] arm64: dts: juno: describe PMUs separately
In-Reply-To: <1443779708-26789-5-git-send-email-mark.rutland@arm.com>
References: <1443779708-26789-1-git-send-email-mark.rutland@arm.com>
 <1443779708-26789-5-git-send-email-mark.rutland@arm.com>
Message-ID: <20151008162512.GA17100@bart.dudau.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 10:55:06AM +0100, Mark Rutland wrote:
> The A57 and A53 PMUs in Juno support different events, so describe them
> separately in both the Juno and Juno R1 DTs.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>

I'm sending this from my personal account as the corporate one is having hickups
with external mailing lists.

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Best regards,
Liviu

> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-r1.dts | 18 +++++++++++-------
>  arch/arm64/boot/dts/arm/juno.dts    | 18 +++++++++++-------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> Note: as older kernels don't handle multiple PMUs being listed in the DT, this
> should be applied after the core changes.
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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...
