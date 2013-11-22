From: mgr@pengutronix.de (Michael Grzeschik)
Date: Fri, 22 Nov 2013 16:49:47 +0100
Subject: [PATCH 2/4 V2] ARM: mx28: Add USB PHY overcurrent pinmux
In-Reply-To: <1345852300-2213-2-git-send-email-marex@denx.de>
References: <1345852300-2213-1-git-send-email-marex@denx.de>
 <1345852300-2213-2-git-send-email-marex@denx.de>
Message-ID: <20131122154947.GE24508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek, Peter,

On Sat, Aug 25, 2012 at 01:51:38AM +0200, Marek Vasut wrote:
> Add the pinmux settings for USB PHY overcurrent pins.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx28.dtsi |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> V2: This is pulled from the M28EVK and SPS1 board files, put it into common
>     file.
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index b996c2d..3cba62d 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -520,6 +520,36 @@
>  					fsl,voltage = <1>;
>  					fsl,pull-up = <1>;
>  				};
> +
> +				usbphy0_pins_a: usbphy0 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2152 /* MX28_PAD_SSP2_SS2__USB0_OVERCURRENT */
> +					>;
> +					fsl,drive-strength = <2>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
> +				usbphy0_pins_b: usbphy0 at 1 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x3061 /* MX28_PAD_AUART1_CTS__USB0_OVERCURRENT */
> +					>;
> +					fsl,drive-strength = <2>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
> +				usbphy1_pins_a: usbphy1 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2142 /* MX28_PAD_SSP2_SS1__USB1_OVERCURRENT */
> +					>;
> +					fsl,drive-strength = <2>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
>  			};
>  
>  			digctl at 8001c000 {
> -- 
> 1.7.10.4


@Marek: Did you test the overcurrent functionality with the MX28 and this pinmux?

I currently can not trigger any overcurrent events and also don't
see changes in the PORTSC register after pulling the OC pin to 3V3.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
