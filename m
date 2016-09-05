From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  5 Sep 2016 16:27:47 -0300
Subject: [PATCH v2 1/4] ARM: dts: imx23: Remove skeleton.dtsi inclusion
Message-ID: <1473103670-15922-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove skeleton.dtsi to avoid the following build warning with W=1:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Remove skeleton.dtsi dependency (Rob)

 arch/arm/boot/dts/imx23.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 440ee9a..9d0e9e1 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -9,10 +9,12 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx23-pinfunc.h"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	interrupt-parent = <&icoll>;
 
 	aliases {
-- 
1.9.1
