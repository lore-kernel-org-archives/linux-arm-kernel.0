From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 2 Jun 2015 11:47:43 +0100
Subject: [PATCH 6/6] arm64: dts: juno: describe PMUs separately
In-Reply-To: <1432657876-1362-7-git-send-email-mark.rutland@arm.com>
References: <1432657876-1362-1-git-send-email-mark.rutland@arm.com>
 <1432657876-1362-7-git-send-email-mark.rutland@arm.com>
Message-ID: <20150602104743.GI2175@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 05:31:16PM +0100, Mark Rutland wrote:
> The A57 and A53 PMUs in Juno support different events, so describe them
> separately.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Hi Mark,

Arnd has pulled my patches that add juno-r1.dts to the mix and he is going
to send a pull request for v4.2. Care to respin this patch to add support
for Juno R1 as well?

Best regards,
Liviu

> ---
>  arch/arm64/boot/dts/arm/juno.dts | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index 5e9110a..015be74 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -118,17 +118,21 @@
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
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
