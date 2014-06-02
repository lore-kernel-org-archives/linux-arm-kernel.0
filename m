From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Mon,  2 Jun 2014 11:21:06 +0200
Subject: [PATCH 5/5] ARM: dts: berlin: add SMP related nodes and properties
 for BG2Q
In-Reply-To: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1401700866-24804-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required nodes and properties into the Berlin BG2Q device tree to
take advantage of the newly introduced SMP support. Add the scu and
cpu-ctrl nodes along with the CPUs enable-method property.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 07452a7483fa..570f12f7e9c4 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -17,6 +17,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "marvell,berlin-smp";
 
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
@@ -94,6 +95,11 @@
 			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		scu: snoop-control-unit at ad0000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xad0000 0x58>;
+		};
+
 		gic: interrupt-controller at ad1000 {
 			compatible = "arm,cortex-a9-gic";
 			reg = <0xad1000 0x1000>, <0xad0100 0x100>;
@@ -101,6 +107,11 @@
 			#interrupt-cells = <3>;
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
