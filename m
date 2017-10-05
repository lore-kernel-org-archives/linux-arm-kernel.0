From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:42 +0200
Subject: [PATCH 07/20] ARM: dts: sun4i: Remove skeleton and memory to avoid
 warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b1acecf3049f3bc96266f2db22149bf0b18e7a30.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using skeleton.dtsi will create a memory node that will generate a warning
in DTC. However, that node will be created by the bootloader, so we can
just remove it entirely in order to remove that warning.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 1876abb62ec7..f64544f615ea 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -41,14 +41,14 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/clock/sun4i-a10-ccu.h>
 #include <dt-bindings/reset/sun4i-a10-ccu.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&intc>;
 
 	aliases {
@@ -160,10 +160,6 @@
 		};
 	};
 
-	memory {
-		reg = <0x40000000 0x80000000>;
-	};
-
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
git-series 0.9.1
