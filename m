From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 15 Feb 2013 15:10:01 +0100
Subject: [PATCH] ARM: dts: imx6q: add PMU
Message-ID: <1360937401-2442-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM Cortex A9 Performance Monitor Unit (PMU) support.
On i.MX6 a combined interrupt on hardware line #126 is used
(i.MX6 TRM: Performance Unit interrupt).

For more details see Documentation/devicetree/bindings/arm/pmu.txt

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index d6265ca..73f9664 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -138,6 +138,11 @@
 			cache-level = <2>;
 		};
 
+		pmu {
+			compatible = "arm,cortex-a9-pmu";
+			interrupts = <0 94 0x04>;
+		};
+
 		aips-bus at 02000000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
-- 
1.7.0.4
