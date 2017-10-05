From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:49 +0200
Subject: [PATCH 14/20] ARM: dts: sun9i: Remove skeleton to avoid warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <3c127ab5cd3ef874a51d9e8b37277fb87e7f774f.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using skeleton.dtsi will create a memory node that will generate a warning
in DTC. However, that node will be created by the bootloader, so we can
just remove it entirely in order to remove that warning.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80.dtsi |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 19b01d0bdc37..190d1f9df2d4 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -42,8 +42,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton64.dtsi"
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include <dt-bindings/clock/sun9i-a80-ccu.h>
@@ -54,6 +52,8 @@
 #include <dt-bindings/reset/sun9i-a80-usb.h>
 
 / {
+	#address-cells = <2>;
+	#size-cells = <2>;
 	interrupt-parent = <&gic>;
 
 	cpus {
@@ -109,11 +109,6 @@
 		};
 	};
 
-	memory {
-		/* 8GB max. with LPAE */
-		reg = <0 0x20000000 0x02 0>;
-	};
-
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
git-series 0.9.1
