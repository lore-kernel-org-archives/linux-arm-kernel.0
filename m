From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Aug 2013 17:17:23 +0800
Subject: [PATCH 6/8] ARM: dts: mxs: add pin config options for usbphy pins
In-Reply-To: <1375966287-6784-7-git-send-email-LW@KARO-electronics.de>
References: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
 <1375966287-6784-7-git-send-email-LW@KARO-electronics.de>
Message-ID: <20130812091719.GB25292@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 02:51:25PM +0200, Lothar Wa?mann wrote:
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/boot/dts/imx28.dtsi |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 7363fde..f941648 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -731,6 +731,17 @@
>  					fsl,pull-up = <0>;
>  				};
>  
> +				usbphy0_pins_c: usbphy0 at 2 {
> +					reg = <2>;
> +					fsl,pinmux-ids = <
> +						0x0123 /* MX28_PAD_GPMI_CE2N__GPIO_0_18 - USBOTG_VBUSEN */
> +						0x0133 /* MX28_PAD_GPMI_CE3N__GPIO_0_19 - USBOTH_OC */

The GPIO usage is something board specific and should be set up at
board level DTS.

Shawn

> +					>;
> +					fsl,drive-strength = <2>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
>  				usbphy1_pins_a: usbphy1 at 0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <
> @@ -740,6 +751,17 @@
>  					fsl,voltage = <1>;
>  					fsl,pull-up = <0>;
>  				};
> +
> +				usbphy1_pins_b: usbphy1 at 1 {
> +					reg = <1>;
> +					fsl,pinmux-ids = <
> +						0x31b3 /* MX28_PAD_SPDIF__GPIO_3_27 - USBH_VBUSEN */
> +						0x4143 /* MX28_PAD_JTAG_RTCK__GPIO_4_20 - USBH_OC */
> +					>;
> +					fsl,drive-strength = <2>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
>  			};
>  
>  			digctl: digctl at 8001c000 {
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
