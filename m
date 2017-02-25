From: florian.vaussard@gmail.com (Florian Vaussard)
Date: Sat, 25 Feb 2017 06:54:29 +0100
Subject: [PATCH 6/6] ARM: dts: socfpga: Do not include skeleton.dtsi
In-Reply-To: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
Message-ID: <1488002069-22404-7-git-send-email-florian.vaussard@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The skeleton.dtsi file is now deprecated as noted in commit 9c0da3cc61f1
("ARM: dts: explicitly mark skeleton.dtsi as deprecated"). The SoCFPGA
device trees already contain the nodes that are defined in skeleton.dtsi
(#address-cells, #size-cells, chosen, aliases, memory).

Including skeleton.dtsi is useless and will produce the following
warning when compiled with W=1:

Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 arch/arm/boot/dts/socfpga.dtsi         | 1 -
 arch/arm/boot/dts/socfpga_arria10.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 25a68af..774c239 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -15,7 +15,6 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/reset/altr,rst-mgr.h>
 
 / {
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 4e1f653..bead79e 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -14,7 +14,6 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/altr,rst-mgr-a10.h>
 
-- 
2.7.4
