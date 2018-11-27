From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:07 +0100
Subject: [PATCH 06/77] ARM: dts: sun5i: Remove skeleton to avoid warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <856695e90059a2e85dd3b0aacc9e6881967b0ccf.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using skeleton.dtsi will create a memory node that will generate a warning
in DTC. However, that node will be created by the bootloader, so we can
just remove it entirely in order to remove that warning.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 --
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 --
 arch/arm/boot/dts/sun5i.dtsi      | 4 ++--
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 7f76250f4228..0c0c5e08520f 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -42,8 +42,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include "sun5i.dtsi"
 
 #include <dt-bindings/dma/sun4i-a10.h>
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index b1d827765530..a75ca4504a75 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -42,8 +42,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include "sun5i.dtsi"
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 97236b112b01..07b60462356e 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -42,14 +42,14 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/clock/sun5i-ccu.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/reset/sun5i-ccu.h>
 
 / {
 	interrupt-parent = <&intc>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	cpus {
 		#address-cells = <1>;
-- 
git-series 0.9.1
