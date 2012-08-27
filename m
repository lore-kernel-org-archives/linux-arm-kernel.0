From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 27 Aug 2012 13:23:27 -0300
Subject: [PATCH 1/3] ARM: mx28evk: Add SPI flash support
Message-ID: <1346084609-31407-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx28evk has a free slot (J89) which can be used to populate an SPI NOR Flash.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index ab78ee5..8a9a2f4 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -46,6 +46,23 @@
 				wp-gpios = <&gpio0 28 0>;
 			};
 
+			ssp2: ssp at 80014000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx28-spi";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi2_pins_a>;
+				status = "okay";
+
+				flash: m25p80 at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "sst,sst25vf016b";
+					spi-max-frequency = <40000000>;
+					reg = <0>;
+				};
+			};
+
 			pinctrl at 80018000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
-- 
1.7.9.5
