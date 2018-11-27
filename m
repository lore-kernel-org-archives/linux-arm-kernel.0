From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:52 +0100
Subject: [PATCH 51/77] ARM: dts: sun8i: a23/a33: Remove skeleton and memory to
 avoid warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <44c1d032168b5accb2a4bbc6d5df7884ce688277.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using skeleton.dtsi will create a memory node that will generate a warning
in DTC. However, that node will be created by the bootloader, so we can
just remove it entirely in order to remove that warning.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 4 ++--
 arch/arm/boot/dts/sun8i-a23.dtsi     | 4 ----
 arch/arm/boot/dts/sun8i-a33.dtsi     | 4 ----
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index c16ffcc4db7d..a198894a33fd 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -42,8 +42,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include <dt-bindings/clock/sun8i-a23-a33-ccu.h>
@@ -51,6 +49,8 @@
 
 / {
 	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	chosen {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 58e6585b504b..7751c43fc806 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -45,10 +45,6 @@
 #include "sun8i-a23-a33.dtsi"
 
 / {
-	memory {
-		reg = <0x40000000 0x40000000>;
-	};
-
 	soc at 1c00000 {
 		codec: codec at 1c22c00 {
 			#sound-dai-cells = <0>;
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 1c4f7e1930d8..163c3ff7f670 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -186,10 +186,6 @@
 		};
 	};
 
-	memory {
-		reg = <0x40000000 0x80000000>;
-	};
-
 	reserved-memory {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
git-series 0.9.1
