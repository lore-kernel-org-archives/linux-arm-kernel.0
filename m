From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 21 Sep 2017 09:17:58 -0500
Subject: [PATCH 1/3] arm64: dts: stratix10: include the reset manager bindings
Message-ID: <1506003480-22955-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the reset manager includes for Stratix10. Need to use the '#include'
instead of '/include/' to avoid a DTC syntax error.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi      | 1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 631e09a..f7fbc38 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -15,6 +15,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/reset/altr,rst-mgr-s10.h>
 
 / {
 	compatible = "altr,socfpga-stratix10";
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 5907586..46f27ed 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -14,7 +14,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-/include/ "socfpga_stratix10.dtsi"
+#include "socfpga_stratix10.dtsi"
 
 / {
 	model = "SoCFPGA Stratix 10 SoCDK";
-- 
2.7.4
