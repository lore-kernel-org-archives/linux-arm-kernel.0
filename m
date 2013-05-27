From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 May 2013 09:49:37 +0200
Subject: [PATCH v3 1/2] ARM:dts:mx53qsb: Add support for parallel display
In-Reply-To: <1369404571-21356-1-git-send-email-rogerio.pimentel@freescale.com>
References: <1369404571-21356-1-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <20130527074937.GE32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 11:09:30AM -0300, Rogerio Pimentel wrote:
> Add support for CLAA WVGA display for i.MX53 QSB.
> 
> Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>

Both:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> Changes since V2:
> Added status = "disabled" by default to avoid conflict with other
> displays like HDMI card.
>  arch/arm/boot/dts/imx53-qsb.dts |   27 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx53.dtsi    |   35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
> index a885d37..8509db3 100644
> --- a/arch/arm/boot/dts/imx53-qsb.dts
> +++ b/arch/arm/boot/dts/imx53-qsb.dts
> @@ -21,6 +21,33 @@
>  		reg = <0x70000000 0x40000000>;
>  	};
>  
> +	display at di0 {
> +		compatible = "fsl,imx-parallel-display";
> +		crtcs = <&ipu 0>;
> +		interface-pix-fmt = "rgb565";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ipu_disp0_1>;
> +		status = "disabled";
> +		display-timings {
> +			claawvga {
> +				native-mode;
> +				clock-frequency = <27000000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hback-porch = <40>;
> +				hfront-porch = <60>;
> +				vback-porch = <10>;
> +				vfront-porch = <10>;
> +				hsync-len = <20>;
> +				vsync-len = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +		};
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 2dbdc90..3a565ff 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -544,6 +544,41 @@
>  					};
>  				};
>  
> +				ipu_disp0 {
> +					pinctrl_ipu_disp0_1: ipudisp0grp-1 {
> +						fsl,pins = <
> +						MX53_PAD_DI0_DISP_CLK__IPU_DI0_DISP_CLK	0x5
> +						MX53_PAD_DI0_PIN15__IPU_DI0_PIN15		0x5
> +						MX53_PAD_DI0_PIN2__IPU_DI0_PIN2		0x5
> +						MX53_PAD_DI0_PIN3__IPU_DI0_PIN3 		0x5
> +						MX53_PAD_DISP0_DAT0__IPU_DISP0_DAT_0		0x5
> +						MX53_PAD_DISP0_DAT1__IPU_DISP0_DAT_1		0x5
> +						MX53_PAD_DISP0_DAT2__IPU_DISP0_DAT_2		0x5
> +						MX53_PAD_DISP0_DAT3__IPU_DISP0_DAT_3		0x5
> +						MX53_PAD_DISP0_DAT4__IPU_DISP0_DAT_4		0x5
> +						MX53_PAD_DISP0_DAT5__IPU_DISP0_DAT_5		0x5
> +						MX53_PAD_DISP0_DAT6__IPU_DISP0_DAT_6		0x5
> +						MX53_PAD_DISP0_DAT7__IPU_DISP0_DAT_7		0x5
> +						MX53_PAD_DISP0_DAT8__IPU_DISP0_DAT_8		0x5
> +						MX53_PAD_DISP0_DAT9__IPU_DISP0_DAT_9		0x5
> +						MX53_PAD_DISP0_DAT10__IPU_DISP0_DAT_10		0x5
> +						MX53_PAD_DISP0_DAT11__IPU_DISP0_DAT_11		0x5
> +						MX53_PAD_DISP0_DAT12__IPU_DISP0_DAT_12		0x5
> +						MX53_PAD_DISP0_DAT13__IPU_DISP0_DAT_13		0x5
> +						MX53_PAD_DISP0_DAT14__IPU_DISP0_DAT_14		0x5
> +						MX53_PAD_DISP0_DAT15__IPU_DISP0_DAT_15		0x5
> +						MX53_PAD_DISP0_DAT16__IPU_DISP0_DAT_16		0x5
> +						MX53_PAD_DISP0_DAT17__IPU_DISP0_DAT_17		0x5
> +						MX53_PAD_DISP0_DAT18__IPU_DISP0_DAT_18		0x5
> +						MX53_PAD_DISP0_DAT19__IPU_DISP0_DAT_19		0x5
> +						MX53_PAD_DISP0_DAT20__IPU_DISP0_DAT_20		0x5
> +						MX53_PAD_DISP0_DAT21__IPU_DISP0_DAT_21		0x5
> +						MX53_PAD_DISP0_DAT22__IPU_DISP0_DAT_22		0x5
> +						MX53_PAD_DISP0_DAT23__IPU_DISP0_DAT_23		0x5
> +						>;
> +					};
> +				};
> +
>  				ipu_disp1 {
>  					pinctrl_ipu_disp1_1: ipudisp1grp-1 {
>  						fsl,pins = <
> -- 
> 1.7.10.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
