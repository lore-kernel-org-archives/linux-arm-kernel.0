From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 30 Aug 2016 22:52:48 +0200
Subject: [PATCH 1/3] ARM: dts: armv7-m: remove skeleton.dtsi include
In-Reply-To: <20160830205250.15616-1-manabian@gmail.com>
References: <20160830205250.15616-1-manabian@gmail.com>
Message-ID: <20160830205250.15616-2-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove skeleton.dtsi from the common ARM Cortex-M dtsi. This will allow
us to remove skeleton.dtsi on a per platform basis and get rid of the
unit address warning on the memory nodes without getting duplicate memory
nodes.

See 3ebee5a2e141 ("arm64: dts: kill skeleton.dtsi") for additional
reasons not to use the skeleton.dtsi.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/armv7-m.dtsi   | 2 --
 arch/arm/boot/dts/efm32gg.dtsi   | 2 ++
 arch/arm/boot/dts/lpc18xx.dtsi   | 1 +
 arch/arm/boot/dts/mps2.dtsi      | 1 +
 arch/arm/boot/dts/stm32f429.dtsi | 1 +
 arch/arm/boot/dts/vf610m4.dtsi   | 1 +
 6 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
index 16331aa..ba332e3 100644
--- a/arch/arm/boot/dts/armv7-m.dtsi
+++ b/arch/arm/boot/dts/armv7-m.dtsi
@@ -1,5 +1,3 @@
-#include "skeleton.dtsi"
-
 / {
 	nvic: interrupt-controller at e000e100  {
 		compatible = "arm,armv7m-nvic";
diff --git a/arch/arm/boot/dts/efm32gg.dtsi b/arch/arm/boot/dts/efm32gg.dtsi
index c747983..d9dbf7f 100644
--- a/arch/arm/boot/dts/efm32gg.dtsi
+++ b/arch/arm/boot/dts/efm32gg.dtsi
@@ -4,6 +4,8 @@
  * Documentation available from
  * http://www.silabs.com/Support%20Documents/TechnicalDocs/EFM32GG-RM.pdf
  */
+
+#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include "dt-bindings/clock/efm32-cmu.h"
 
diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 1cd39fd..a1ecfe3 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -11,6 +11,7 @@
  *
  */
 
+#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 
 #include "dt-bindings/clock/lpc18xx-cgu.h"
diff --git a/arch/arm/boot/dts/mps2.dtsi b/arch/arm/boot/dts/mps2.dtsi
index e3fed8d..efb8a03 100644
--- a/arch/arm/boot/dts/mps2.dtsi
+++ b/arch/arm/boot/dts/mps2.dtsi
@@ -42,6 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 35df462..8e69328 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -45,6 +45,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
 
diff --git a/arch/arm/boot/dts/vf610m4.dtsi b/arch/arm/boot/dts/vf610m4.dtsi
index 9ffe2eb..9f2c731 100644
--- a/arch/arm/boot/dts/vf610m4.dtsi
+++ b/arch/arm/boot/dts/vf610m4.dtsi
@@ -42,6 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include "vfxxx.dtsi"
 
-- 
2.9.3
