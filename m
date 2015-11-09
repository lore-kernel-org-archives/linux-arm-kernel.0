From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon,  9 Nov 2015 10:51:51 -0800
Subject: [PATCH] ARM: dt: zynq: Add labels to cpu nodes to allow overriding
 OPPs.
Message-ID: <1447095111-22969-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By adding labels to the cpu nodes in the dtsi, a dts that
includes it can change the OPPs by referencing the cpu0
through the label.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index dc0457e..0093722 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -19,7 +19,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
@@ -33,7 +33,7 @@
 			>;
 		};
 
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <1>;
-- 
2.4.3
