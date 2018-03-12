From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 12 Mar 2018 12:10:21 +0100
Subject: [PATCH] ARM64: dts: meson: bump mali450 clk to 744MHz
Message-ID: <1520853021-5412-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Mali-450 IP can run up to 744MHz, bump the frequency using
the GP0 PLL clock.

Cc: Michal Lazo <michal.lazo@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi     | 11 +++++++----
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 3290a4dc..6013d32 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -284,14 +284,17 @@
 		 * MALI_0 and MALI_1 muxed to a single clock by a glitch
 		 * free mux to safely change frequency while running.
 		 */
-		assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
+		assigned-clocks = <&clkc CLKID_GP0_PLL>,
+				  <&clkc CLKID_MALI_0_SEL>,
 				  <&clkc CLKID_MALI_0>,
 				  <&clkc CLKID_MALI>; /* Glitch free mux */
-		assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+		assigned-clock-parents = <0>, /* Do Nothing */
+					 <&clkc CLKID_GP0_PLL>,
 					 <0>, /* Do Nothing */
 					 <&clkc CLKID_MALI_0>;
-		assigned-clock-rates = <0>, /* Do Nothing */
-				       <666666666>,
+		assigned-clock-rates = <744000000>,
+				       <0>, /* Do Nothing */
+				       <744000000>,
 				       <0>; /* Do Nothing */
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
index f06cc234..972df67 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
@@ -30,14 +30,17 @@
 		 * MALI_0 and MALI_1 muxed to a single clock by a glitch
 		 * free mux to safely change frequency while running.
 		 */
-		assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
+		assigned-clocks = <&clkc CLKID_GP0_PLL>,
+				  <&clkc CLKID_MALI_0_SEL>,
 				  <&clkc CLKID_MALI_0>,
 				  <&clkc CLKID_MALI>; /* Glitch free mux */
-		assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+		assigned-clock-parents = <0>, /* Do Nothing */
+					 <&clkc CLKID_GP0_PLL>,
 					 <0>, /* Do Nothing */
 					 <&clkc CLKID_MALI_0>;
-		assigned-clock-rates = <0>, /* Do Nothing */
-				       <666666666>,
+		assigned-clock-rates = <744000000>,
+				       <0>, /* Do Nothing */
+				       <744000000>,
 				       <0>; /* Do Nothing */
 	};
 };
-- 
2.7.4
