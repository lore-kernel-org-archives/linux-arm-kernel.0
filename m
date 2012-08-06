From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Aug 2012 10:29:17 +0800
Subject: [PATCH 10/10] ARM: mx28: Add SPI pinmux into imx28.dtsi
In-Reply-To: <1344007575-11448-11-git-send-email-marex@denx.de>
References: <1344007575-11448-1-git-send-email-marex@denx.de>
 <1344007575-11448-11-git-send-email-marex@denx.de>
Message-ID: <20120806022915.GB18471@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2012 at 05:26:15PM +0200, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Attila Kinali <attila@kinali.ch>
> Cc: Chris Ball <cjb@laptop.org>
> CC: Dong Aisheng <b29396@freescale.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx28.dtsi |   39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index badc76a..4a0f12c 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -507,6 +507,45 @@
>  					fsl,voltage = <1>;
>  					fsl,pull-up = <0>;
>  				};
> +
> +				spi0_pins_a: spi0 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids =
> +						<0x2000 0x2010 0x2020 0x2030
> +						0x2040 0x2050 0x2060 0x2070
> +						0x2080 0x2090 0x20a0>;

Please follow the new format, one id per line with a comment afterward.

> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				spi1_pins_a: spi1 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids =
> +						<0x20c0 0x20d0 0x20e0 0x20f0>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				spi2_pins_a: spi2 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids =
> +						<0x2100 0x2110 0x2120
> +						0x2130 0x2140 0x2150>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				spi3_pins_a: spi3 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids =
> +						<0x2180 0x2190 0x21a0 0x21b0>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};

I do not accept patch adding pinctrl settings alone.  Instead, I want
them to be added together with the users (board dts).  That said, we
do not want to enumerate all the possible pinctrl settings but just
the ones being used.

>  			};
>  
>  			digctl at 8001c000 {
> -- 
> 1.7.10.4
> 

-- 
Regards,
Shawn
