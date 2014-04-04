From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  4 Apr 2014 16:14:13 -0700
Subject: [PATCH v2 2/5] ARM: zynq: dt: Convert to preprocessor includes
In-Reply-To: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1396653256-28397-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert all Zynq DT files to the dtc preprocessor include syntax.
This allows to include header files in the devicetrees like other
SoC-types already do.

Inspired-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
(http://www.spinics.net/lists/arm-kernel/msg319832.html)

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

Changes in v2: None

 arch/arm/boot/dts/zynq-7000.dtsi | 3 ++-
 arch/arm/boot/dts/zynq-zc702.dts | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts | 2 +-
 arch/arm/boot/dts/zynq-zed.dts   | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 20a13cba65a3..66613d04de5d 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -10,7 +10,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-/include/ "skeleton.dtsi"
+
+#include "skeleton.dtsi"
 
 / {
 	compatible = "xlnx,zynq-7000";
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index c913f77a21eb..07713d3c716a 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -12,7 +12,7 @@
  * GNU General Public License for more details.
  */
 /dts-v1/;
-/include/ "zynq-7000.dtsi"
+#include "zynq-7000.dtsi"
 
 / {
 	model = "Zynq ZC702 Development Board";
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 88f62c50382e..cf6566cdb02a 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -13,7 +13,7 @@
  * GNU General Public License for more details.
  */
 /dts-v1/;
-/include/ "zynq-7000.dtsi"
+#include "zynq-7000.dtsi"
 
 / {
 	model = "Zynq ZC706 Development Board";
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 82d7ef1a9a9c..1541716e2cfb 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -13,7 +13,7 @@
  * GNU General Public License for more details.
  */
 /dts-v1/;
-/include/ "zynq-7000.dtsi"
+#include "zynq-7000.dtsi"
 
 / {
 	model = "Zynq Zed Development Board";
-- 
1.9.1.1.gbb9f595
