From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Feb 2018 15:17:23 -0300
Subject: [PATCH 1/5] ARM: dts: vf500: Remove skeleton.dtsi inclusion
Message-ID: <1519755447-9666-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since commit 9c0da3cc61f1 ("ARM: dts: explicitly mark skeleton.dtsi as
deprecated") the inclusion of skeleton.dtsi is deprecated, so
remove it as this file will eventually go away someday.

Move its content to the SoC dtsi file, so that the resultant dtb
is the same.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/vf500.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index 348bcd3..1e3b479 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -39,11 +39,16 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include "vfxxx.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	chosen { };
+	aliases { };
+	memory { device_type = "memory"; reg = <0 0>; };
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.7.4
