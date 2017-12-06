From: khilman@baylibre.com (Kevin Hilman)
Date: Wed,  6 Dec 2017 11:30:05 -0800
Subject: [PATCH] ARM64: dts: amlogic: use generic bus node names
Message-ID: <20171206193005.24171-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT spec recommends that node-names have generic names like "bus".
Fix that in the Amlogic DTs, while leaving the label names to have more
SoC-specific names that match with the HW documentation.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b932a784b02a..e7213eb53958 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -113,7 +113,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		cbus: cbus at ffd00000 {
+		cbus: bus at ffd00000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xffd00000 0x0 0x25000>;
 			#address-cells = <2>;
@@ -175,7 +175,7 @@
 			};
 		};
 
-		aobus: aobus at ff800000 {
+		aobus: bus at ff800000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xff800000 0x0 0x100000>;
 			#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 7cdbf58a062f..6cb3c2a52baf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -211,7 +211,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		cbus: cbus at c1100000 {
+		cbus: bus at c1100000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc1100000 0x0 0x100000>;
 			#address-cells = <2>;
@@ -366,7 +366,7 @@
 			};
 		};
 
-		aobus: aobus at c8100000 {
+		aobus: bus at c8100000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc8100000 0x0 0x100000>;
 			#address-cells = <2>;
@@ -453,7 +453,7 @@
 			};
 		};
 
-		hiubus: hiubus at c883c000 {
+		hiubus: bus at c883c000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc883c000 0x0 0x2000>;
 			#address-cells = <2>;
-- 
2.11.0
