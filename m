From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 2 Mar 2015 11:33:00 +0000
Subject: [PATCH v2 3/3] arm64: dts: add interrupt-affinity property to
 pmu node for juno
In-Reply-To: <1425065549-24661-3-git-send-email-will.deacon@arm.com>
References: <1425065549-24661-1-git-send-email-will.deacon@arm.com>
 <1425065549-24661-3-git-send-email-will.deacon@arm.com>
Message-ID: <20150302113300.GG905@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 07:32:29PM +0000, Will Deacon wrote:
> Make the Juno .dts robust against potential reordering of the CPU nodes
> by adding an explicit interrupt-affinity property to the PMU node. While
> we're at it, fix the PMU interrupts numbers too.

Thanks for spotting this. I can't remember where the PMU numbers originated
from as my GitHub version has a different set as well.

Acked-by:  Liviu Dudau <Liviu.Dudau@arm.com>


> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno.dts | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index d429129ecb3d..c68949c0cca5 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -106,12 +106,18 @@
>  
>  	pmu {
>  		compatible = "arm,armv8-pmuv3";
> -		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
> +			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&A57_0>,
> +				     <&A57_1>,
> +				     <&A53_0>,
> +				     <&A53_1>,
> +				     <&A53_2>,
> +				     <&A53_3>;
>  	};
>  
>  	/include/ "juno-clocks.dtsi"
> -- 
> 2.1.4
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
