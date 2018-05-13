From: hernan@vanguardiasur.com.ar (=?UTF-8?q?Hern=C3=A1n=20Gonzalez?=)
Date: Sun, 13 May 2018 20:27:31 -0300
Subject: [PATCH] ARM: dts: imx53-voipac-dmm-668: Use IRQ_TYPE specifier
Message-ID: <1526254051-3929-1-git-send-email-hernan@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace magic number with the proper IRQ_TYPE specifier to improve DT
readability.

Signed-off-by: Hern?n Gonzalez <hernan@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index df8dafe..f83a8c6 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -150,7 +150,7 @@
 		compatible = "dlg,da9053-aa", "dlg,da9052";
 		reg = <0x48>;
 		interrupt-parent = <&gpio7>;
-		interrupts = <11 0x8>; /* low-level active IRQ at GPIO7_11 */
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* low-level active IRQ at GPIO7_11 */
 
 		regulators {
 			buck1_reg: buck1 {
-- 
2.7.4
