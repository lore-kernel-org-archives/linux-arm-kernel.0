From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 12 Feb 2015 11:42:47 +0100
Subject: [PATCH v2] ARM: dts: zynq: Add OCM node
Message-ID: <6df19b400e314ef8228be475bb8ba83765683016.1423737765.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OCM node for all zynq boards. OCM location
can changed but for all current boards this
is the location where OCM is.`

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Move node to board file suggested by Mark

This patch is done based on discussion here.
https://lkml.org/lkml/2014/12/1/396

Mark: I expect you won't like amba bus reference or
am I wrong?

---
 arch/arm/boot/dts/zynq-7000.dtsi | 2 +-
 arch/arm/boot/dts/zynq-zc702.dts | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index a5cd2eda3edf..acca3c180324 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -57,7 +57,7 @@
 		regulator-always-on;
 	};
 
-	amba {
+	amba: amba {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index fb59d34e8ee6..79077c5ac60e 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -50,6 +50,13 @@
 	};
 };
 
+&amba {
+	ocm: sram at fffc0000 {
+		compatible = "mmio-sram";
+		reg = <0xfffc0000 0x10000>;
+	};
+};
+
 &can0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.2.3
