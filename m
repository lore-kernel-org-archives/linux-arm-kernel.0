From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:54:07 +0200
Subject: [PATCH v3 10/11] ARM: mvebu: add SMP support in the Armada 375 device
 tree
In-Reply-To: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483648-26611-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Improve the Armada 375 Device Tree to add the CPU reset Device Tree
node and declare the enabling method for CPUs, both of which are
necessary to get SMP working.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index eceab89..64985c2 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -39,6 +39,8 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "marvell,armada-375-smp";
+
 		cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
@@ -325,6 +327,11 @@
 				clocks = <&coreclk 0>;
 			};
 
+			cpurst at 20800 {
+				compatible = "marvell,armada-370-cpu-reset";
+				reg = <0x20800 0x10>;
+			};
+
 			coherency-fabric at 21010 {
 				compatible = "marvell,armada-375-coherency-fabric";
 				reg = <0x21010 0x1c>;
-- 
1.8.3.2
