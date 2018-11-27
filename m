From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:23 +0100
Subject: [PATCH 22/77] ARM: dts: sun6i: Remove skeleton and memory to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <e3a2d4a2babc00b2baac2a3145505ced92e3130d.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using skeleton.dtsi will create a memory node that will generate a warning
in DTC. However, that node will be created by the bootloader, so we can
just remove it entirely in order to remove that warning.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 1eaa60cd3218..b60aaacbab5e 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -42,8 +42,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -52,6 +50,8 @@
 
 / {
 	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	aliases {
 		ethernet0 = &gmac;
@@ -199,10 +199,6 @@
 		};
 	};
 
-	memory {
-		reg = <0x40000000 0x80000000>;
-	};
-
 	pmu {
 		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
-- 
git-series 0.9.1
