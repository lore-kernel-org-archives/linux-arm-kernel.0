From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  5 Sep 2016 16:27:48 -0300
Subject: [PATCH v2 2/4] ARM: dts: imx28: Remove skeleton.dtsi inclusion
In-Reply-To: <1473103670-15922-1-git-send-email-festevam@gmail.com>
References: <1473103670-15922-1-git-send-email-festevam@gmail.com>
Message-ID: <1473103670-15922-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove skeleton.dtsi to avoid the following build warning with W=1:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Remove skeleton.dtsi dependency (Rob)

 arch/arm/boot/dts/imx28.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 0ad893b..3aabf65 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -10,10 +10,12 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
-#include "skeleton.dtsi"
 #include "imx28-pinfunc.h"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	interrupt-parent = <&icoll>;
 
 	aliases {
-- 
1.9.1
