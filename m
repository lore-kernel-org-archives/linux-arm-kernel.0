From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 Aug 2012 12:24:50 -0300
Subject: [PATCH] ARM: imx6q-sabrelite: Rename 'pinctrl_gpio_hog'
Message-ID: <1345821890-2922-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

'pinctrl_gpio_hog' is used to setup the pin functions, and it is not neccesarily used only
for GPIO pins, so remove 'gpio' from its name to describe a more generic term.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 72f30f3..2e01478 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -46,10 +46,10 @@
 
 			iomuxc at 020e0000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_gpio_hog>;
+				pinctrl-0 = <&pinctrl_hog>;
 
 				gpios {
-					pinctrl_gpio_hog: gpiohog {
+					pinctrl_hog: hog {
 						fsl,pins = <
 							   144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
 							   121  0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
-- 
1.7.9.5
