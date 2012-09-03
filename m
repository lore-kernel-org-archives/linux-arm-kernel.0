From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Sep 2012 22:53:46 +0800
Subject: [PATCHv2 2/3] ARM: dts: mxs Add additionnal muxing options for
 SSP3
In-Reply-To: <1346666749-6094-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1346666749-6094-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346666749-6094-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120903145343.GI2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 12:05:48PM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/imx28.dtsi |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 8497a0e..6c51ff4 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -586,6 +586,17 @@
>  					fsl,voltage = <1>;
>  					fsl,pull-up = <1>;
>  				};
> +
> +				spi3_pins_b: spi3 at 1 {
> +					reg = <1>;
> +					fsl,pinmux-ids = <
> +						0x0181 /* MX28_PAD_GPMI_RDN__SSP3_SCK */
> +						0x01c1 /* MX28_PAD_GPMI_RESETN__SSP3_CMD */

The spi only needs two pins to work?

Has spi3_pins_a been defined?  I haven't seen it.

Regards,
Shawn

> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
>  			};
>  
>  			digctl at 8001c000 {
> -- 
> 1.7.9.5
> 
