From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 27 Jul 2013 11:19:45 +0400
Subject: [PATCH] ARM: i.MX5 clocks: Remove optional clock setup (CKIH1) from
 i.MX51 template
Message-ID: <1374909585-2724-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

External high frequency clock CKIH1 is optional for i.MX51, so move
it setup into boards where it is used.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-apf51.dts   | 4 ----
 arch/arm/boot/dts/imx51-babbage.dts | 4 ++++
 arch/arm/boot/dts/imx51.dtsi        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dts
index 8f7f9ac..b360699 100644
--- a/arch/arm/boot/dts/imx51-apf51.dts
+++ b/arch/arm/boot/dts/imx51-apf51.dts
@@ -26,10 +26,6 @@
 	};
 
 	clocks {
-		ckih1 {
-			clock-frequency = <0>;
-		};
-
 		osc {
 			clock-frequency = <33554432>;
 		};
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 7c670a6..1d337d9 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -63,6 +63,10 @@
 	};
 
 	clocks {
+		ckih1 {
+			clock-frequency = <22579200>;
+		};
+
 		clk_26M: codec_clock {
 			compatible = "fixed-clock";
 			reg=<0>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index d7b0646..f0b25c9 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -47,7 +47,7 @@
 
 		ckih1 {
 			compatible = "fsl,imx-ckih1", "fixed-clock";
-			clock-frequency = <22579200>;
+			clock-frequency = <0>;
 		};
 
 		ckih2 {
-- 
1.8.1.5
