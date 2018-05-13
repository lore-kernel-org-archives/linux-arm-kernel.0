From: hernan@vanguardiasur.com.ar (=?UTF-8?q?Hern=C3=A1n=20Gonzalez?=)
Date: Sun, 13 May 2018 20:28:35 -0300
Subject: [PATCH] ARM: dts: imx6qdl-phytec-pfla02: Use IRQ_TYPE specifier
Message-ID: <1526254115-3999-1-git-send-email-hernan@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace magic number with the proper IRQ_TYPE specifier to improve DT
readability.

Signed-off-by: Hern?n Gonzalez <hernan@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index c58f344..1b79ee7 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -115,7 +115,7 @@
 		compatible = "dlg,da9063";
 		reg = <0x58>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <9 0x8>; /* active-low GPIO2_9 */
+		interrupts = <9 IRQ_TYPE_LOW_LEVEL>; /* active-low GPIO2_9 */
 
 		regulators {
 			vddcore_reg: bcore1 {
-- 
2.7.4
