From: stefan@agner.ch (Stefan Agner)
Date: Thu, 09 Jul 2015 17:07:40 +0200
Subject: [PATCH 1/1] ARM: dts: vfxxx: Include support for esdhc0
 functionality.
In-Reply-To: <1436388666-29376-2-git-send-email-cory.tusar@pid1solutions.com>
References: <1436388666-29376-1-git-send-email-cory.tusar@pid1solutions.com>
 <1436388666-29376-2-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <9cc6942b245ccae55614eb72db803d6b@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-07-08 22:51, Cory Tusar wrote:
> Extend the existing Vybrid eSDHC devicetree implementation to also
> describe the esdhc0 functional block.
> 
> Tested on a custom VF610-based board with a Toshiba THGBM1G5D2EBAI7 eMMC
> module attached to esdhc0.
> 
> Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>

Looks good to me:
Acked-by: Stefan Agner <stefan@agner.ch>

> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 4aa3351..7e97017 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -445,6 +445,17 @@
>  				status = "disabled";
>  			};
>  
> +			esdhc0: esdhc at 400b1000 {
> +				compatible = "fsl,imx53-esdhc";
> +				reg = <0x400b1000 0x1000>;
> +				interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks VF610_CLK_IPG_BUS>,
> +					<&clks VF610_CLK_PLATFORM_BUS>,
> +					<&clks VF610_CLK_ESDHC0>;
> +				clock-names = "ipg", "ahb", "per";
> +				status = "disabled";
> +			};
> +
>  			esdhc1: esdhc at 400b2000 {
>  				compatible = "fsl,imx53-esdhc";
>  				reg = <0x400b2000 0x1000>;
