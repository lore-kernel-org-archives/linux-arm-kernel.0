From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Jun 2013 17:46:26 +0200
Subject: [PATCH] ARM: dts: imx35: Add kernel oftree support
In-Reply-To: <1370948894-757-1-git-send-email-kunadt@schleissheimer.de>
References: <1370948894-757-1-git-send-email-kunadt@schleissheimer.de>
Message-ID: <20130611154626.GS32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivo,

Generally I wonder how this patch works. You do not add a single clock,
so how do the drivers get their clocks?

On Tue, Jun 11, 2013 at 01:08:14PM +0200, Ivo Kunadt wrote:
> diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> new file mode 100644
> index 0000000..1f0a58f
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx35.dtsi
> @@ -0,0 +1,350 @@
> +			i2c1: i2c at 43f80000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx35-i2c", "fsl,imx1-i2c";

Use imx21-i2c instead of imx1-i2c, there has been an incompatible change
between them.

> +			iomuxc at 43fac000 {
> +				compatible = "fsl,imx35-iomuxc";
> +				reg = <0x43fac000 0x4000>;
> +
> +				i2c3 {
> +					pinctrl_i2c3_1: i2c3grp-1 {
> +						fsl,pins = <773 0x1c0 /* MX35_PAD_ATA_DATA12__I2C3_SCL */
> +							777 0x1c0>; /* MX35_PAD_ATA_DATA13__I2C3_SDA */

This doesn't match the current pinctrl driver. We now use defines
instead of these numbers. See the other i.MXs how this is done now.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
