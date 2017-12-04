From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon,  4 Dec 2017 10:04:53 +0100
Subject: [PATCH] ARM64: dts: meson-gx: fix UART pclk clock name
Message-ID: <1512378293-22198-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock-names for pclk was wrongly set to "core", but the bindings
specifies "pclk".
This was not cathed until the legacy non-documented bindings were removed.

Reported-by: Andreas F?rber <afaerber@suse.de>
Fixes: f72d6f6037b7 ("ARM64: dts: meson-gx: use stable UART bindings with correct gate clock")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index ead895a..1fb8b9d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -753,12 +753,12 @@
 
 &uart_B {
 	clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
-	clock-names = "xtal", "core", "baud";
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
 	clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
-	clock-names = "xtal", "core", "baud";
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &vpu {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8ed981f..6524b89 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -688,7 +688,7 @@
 
 &uart_A {
 	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
-	clock-names = "xtal", "core", "baud";
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_AO {
@@ -703,12 +703,12 @@
 
 &uart_B {
 	clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
-	clock-names = "xtal", "core", "baud";
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
 	clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
-	clock-names = "xtal", "core", "baud";
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &vpu {
-- 
2.7.4
