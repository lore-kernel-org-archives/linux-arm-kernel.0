From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 1 May 2013 17:36:09 +0200
Subject: [PATCH 3/3] ARM: dts: Add MC13783 support for i.MX27 Phytec
 PCM038 module
In-Reply-To: <1367405219-19078-3-git-send-email-shc_work@mail.ru>
References: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
 <1367405219-19078-3-git-send-email-shc_work@mail.ru>
Message-ID: <20130501153609.GA31135@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 02:46:59PM +0400, Alexander Shiyan wrote:
> Added MC13783 node to imx27-phytec-phycore DT file.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx27-phytec-phycore.dts | 92 ++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)

You can merge this with the previous patch.

> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
> index b0e9372..5c4fea9 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
> @@ -76,6 +76,98 @@
>  	fsl,spi-num-chipselects = <1>;
>  	cs-gpios = <&gpio4 28 0>;
>  	status = "okay";
> +
> +	pmic: mc13783 at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,mc13783";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <23 0x4>;
> +		fsl,mc13xxx-uses-adc;
> +
> +		regulators {
> +			sw1a_reg: sw1a {
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +			sw1b_reg: sw1b {

Please add a blank line after each node.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
