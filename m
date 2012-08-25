From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 25 Aug 2012 13:01:26 +0800
Subject: [PATCH] ARM: imx6q-sabrelite: Rename 'pinctrl_gpio_hog'
In-Reply-To: <1345821890-2922-1-git-send-email-festevam@gmail.com>
References: <1345821890-2922-1-git-send-email-festevam@gmail.com>
Message-ID: <20120825050123.GH31998@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 12:24:50PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> 'pinctrl_gpio_hog' is used to setup the pin functions, and it is not neccesarily used only
> for GPIO pins, so remove 'gpio' from its name to describe a more generic term.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied with the following changes amended.

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 38755b1..1c57e19 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -48,8 +48,8 @@
                                pinctrl-names = "default";
                                pinctrl-0 = <&pinctrl_hog>;

-                               gpios {
-                                       pinctrl_hog: hog {
+                               hog {
+                                       pinctrl_hog: hoggrp {
                                                fsl,pins = <
                                                        1450 0x80000000 /* MX6Q_PAD_NANDF_D6__GPIO_2_6 */
                                                        1458 0x80000000 /* MX6Q_PAD_NANDF_D7__GPIO_2_7 */


> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 72f30f3..2e01478 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -46,10 +46,10 @@
>  
>  			iomuxc at 020e0000 {
>  				pinctrl-names = "default";
> -				pinctrl-0 = <&pinctrl_gpio_hog>;
> +				pinctrl-0 = <&pinctrl_hog>;
>  
>  				gpios {
> -					pinctrl_gpio_hog: gpiohog {
> +					pinctrl_hog: hog {
>  						fsl,pins = <
>  							   144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
>  							   121  0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
> -- 
> 1.7.9.5
> 
