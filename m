From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  3 Feb 2013 12:18:30 +0100
Subject: [PATCH 2/3] sunxi: dts: Report the pinctrl nodes as gpio-controllers
In-Reply-To: <1359889813-10029-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359889813-10029-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1359890311-10110-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |    4 +++-
 arch/arm/boot/dts/sun5i-a13.dtsi |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index f99f60d..03d2b53 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -18,11 +18,13 @@
 	};
 
 	soc {
-		pinctrl at 01c20800 {
+		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun4i-a10-pinctrl";
 			reg = <0x01c20800 0x400>;
+			gpio-controller;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#gpio-cells = <3>;
 
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PB22", "PB23";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index e112189..945bfac 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -19,11 +19,13 @@
 	};
 
 	soc {
-		pinctrl at 01c20800 {
+		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun5i-a13-pinctrl";
 			reg = <0x01c20800 0x400>;
+			gpio-controller;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#gpio-cells = <3>;
 
 			uart1_pins_a: uart1 at 0 {
 				allwinner,pins = "PE10", "PE11";
-- 
1.7.10.4
