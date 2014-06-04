From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed,  4 Jun 2014 18:03:45 +0200
Subject: [PATCH v2 4/5] ARM: dts: berlin: add SMP related nodes and properties
 for BG2
In-Reply-To: <1401897826-11711-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401897826-11711-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1401897826-11711-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required nodes and properties into the Berlin BG2 device tree to
take advantage of the newly introduced SMP support. Add the scu and
cpu-ctrl nodes along with the CPUs enable-method property.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 56a1af2f1052..f38ddda8a75e 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -21,6 +21,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "marvell,berlin-smp";
 
 		cpu at 0 {
 			compatible = "marvell,pj4b";
@@ -72,6 +73,11 @@
 			cache-level = <2>;
 		};
 
+		scu: snoop-control-unit at ad0000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xad0000 0x58>;
+		};
+
 		gic: interrupt-controller at ad1000 {
 			compatible = "arm,cortex-a9-gic";
 			reg = <0xad1000 0x1000>, <0xad0100 0x0100>;
@@ -86,6 +92,11 @@
 			clocks = <&sysclk>;
 		};
 
+		cpu-ctrl at dd0000 {
+			compatible = "marvell,berlin-cpu-ctrl";
+			reg = <0xdd0000 0x10000>;
+		};
+
 		apb at e80000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
1.9.1
