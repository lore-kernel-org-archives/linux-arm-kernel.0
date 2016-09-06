From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 6 Sep 2016 12:53:12 -0300
Subject: [PATCH 6/9] ARM: dts: imx27: Remove skeleton.dtsi
In-Reply-To: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
References: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1473177196-29371-6-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inclusion of skeleton.dtsi causes the following build warning:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Instead of fixing skeleton.dtsi, just add the top level definitions
for address-cells and size-cell and remove its inclusion.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx27.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index f818ea4..9d8b596 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -9,7 +9,6 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx27-pinfunc.h"
 
 #include <dt-bindings/clock/imx27-clock.h>
@@ -18,6 +17,9 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec;
 		gpio0 = &gpio1;
-- 
1.9.1
