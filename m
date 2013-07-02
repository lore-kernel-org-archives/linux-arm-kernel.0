From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue,  2 Jul 2013 20:02:24 +0400
Subject: [PATCH 1/6] ARM: dts: i.MX27: Move IIM node under AIPI2 bus
Message-ID: <1372780949-31897-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves IIM node under AIPI2 bus, since this is proper
location for this module.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index a587294..516473c 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -375,13 +375,6 @@
 				clocks = <&clks 41>, <&clks 61>;
 				clock-names = "ipg", "per";
 			};
-
-			iim: iim at 10028000 {
-				compatible = "fsl,imx27-iim";
-				reg = <0x10028000 0x1000>;
-				interrupts = <62>;
-				clocks = <&clks 38>;
-			};
 		};
 
 		aipi at 10020000 { /* AIPI2 */
@@ -423,6 +416,13 @@
 				#clock-cells = <1>;
 			};
 
+			iim: iim at 10028000 {
+				compatible = "fsl,imx27-iim";
+				reg = <0x10028000 0x1000>;
+				interrupts = <62>;
+				clocks = <&clks 38>;
+			};
+
 			fec: ethernet at 1002b000 {
 				compatible = "fsl,imx27-fec";
 				reg = <0x1002b000 0x4000>;
-- 
1.8.1.5
