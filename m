From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 6 Sep 2016 12:53:10 -0300
Subject: [PATCH 4/9] ARM: dts: imx25: Remove skeleton.dtsi
In-Reply-To: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
References: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1473177196-29371-4-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inclusion of skeleton.dtsi causes the following build warning:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Instead of fixing skeleton.dtsi, just add the top level definitions
for address-cells and size-cell and remove its inclusion.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx25.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index af6af87..831d09a 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -9,10 +9,12 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx25-pinfunc.h"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec;
 		gpio0 = &gpio1;
-- 
1.9.1
