From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 6 Sep 2016 12:53:07 -0300
Subject: [PATCH 1/9] ARM: dts: imx1: Remove skeleton.dtsi
Message-ID: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inclusion of skeleton.dtsi causes the following build warning:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Instead of fixing skeleton.dtsi, just add the top level definitions
for address-cells and size-cell and remove its inclusion.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx1.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index 22f5d1d..b792eee 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -9,7 +9,6 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx1-pinfunc.h"
 
 #include <dt-bindings/clock/imx1-clock.h>
@@ -17,6 +16,9 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
-- 
1.9.
