From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jun 2014 15:22:52 +0200
Subject: [PATCH 11/16] ARM: mvebu: dts: Add CA9 MPcore SoC Controller node
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1403875377-940-12-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CA9 MPcore SoC Control block allows to do some configuration that
the SoC could use for a specific use case. In most cases the defaults
case is enough. However there is few exception: for cpuidle we need to
use the CA9 MPcore Reset Control register.

The documentation is also updated in the same time.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: devicetree at vger.kernel.org
---
 .../devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt | 14 ++++++++++++++
 arch/arm/boot/dts/armada-38x.dtsi                          |  5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt b/Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
new file mode 100644
index 000000000000..0a2df51ba560
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
@@ -0,0 +1,14 @@
+Marvell Armada 38x CA9 MPcore SoC Controller
+============================================
+
+Required properties:
+
+- compatible: Should be "marvell,armada-380-mpcore-soc-ctrl".
+
+- reg: should be register base and length as documented in the
+  datasheet for the CA9 MPcore SoC Control registers
+
+mpcore-soc-ctrl at 20d20 {
+	compatible = "marvell,armada-380-mpcore-soc-ctrl";
+	reg = <0x20d20 0x6c>;
+};
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 689fa1a46728..242d0ecc99f3 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -286,6 +286,11 @@
 				reg = <0x20800 0x10>;
 			};
 
+			mpcore-soc-ctrl at 20d20 {
+				compatible = "marvell,armada-380-mpcore-soc-ctrl";
+				reg = <0x20d20 0x6c>;
+			};
+
 			coherency-fabric at 21010 {
 				compatible = "marvell,armada-380-coherency-fabric";
 				reg = <0x21010 0x1c>;
-- 
1.8.1.2
