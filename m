From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Sep 2012 10:49:51 +0800
Subject: [PATCHv3 2/2] dts: mxs: spi: Add SSP3 to the 10049 board
In-Reply-To: <1346748243-28675-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1346748243-28675-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346748243-28675-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120905024949.GT2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 10:44:03AM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied with subject prefix reworded as below.

  ARM: dts: cfa10049: Add SSP3 to the 10049 board

> ---
>  arch/arm/boot/dts/imx28-cfa10049.dts |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
> index e0e4b8c..845663e 100644
> --- a/arch/arm/boot/dts/imx28-cfa10049.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10049.dts
> @@ -20,6 +20,28 @@
>  	compatible = "crystalfontz,cfa10049", "crystalfontz,cfa10036", "fsl,imx28";
>  
>  	apb at 80000000 {
> +		apbh at 80000000 {
> +			pinctrl at 80018000 {
> +				spi3_pins_cfa10049: spi3-cfa10049 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x0181 /* MX28_PAD_GPMI_RDN__SSP3_SCK */
> +						0x01c1 /* MX28_PAD_GPMI_RESETN__SSP3_CMD */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +			};
> +
> +			ssp3: ssp at 80016000 {
> +				compatible = "fsl,imx28-spi";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&spi3_pins_cfa10049>;
> +				status = "okay";
> +			};
> +		};
> +
>  		apbx at 80040000 {
>  			i2c1: i2c at 8005a000 {
>  				pinctrl-names = "default";
> -- 
> 1.7.9.5
> 
