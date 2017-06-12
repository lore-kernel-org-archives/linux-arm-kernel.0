From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 12 Jun 2017 11:57:45 +0200
Subject: [PATCH v3 9/9] arm64: marvell: dts: add xmdio nodes for 7k/8k
In-Reply-To: <20170612095745.11300-1-antoine.tenart@free-electrons.com>
References: <20170612095745.11300-1-antoine.tenart@free-electrons.com>
Message-ID: <20170612095745.11300-10-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the description of the xMDIO bus for the Marvell Armada 7k and
Marvell Armada 8k; for both CP110 slave and master. This bus is found
on Marvell Ethernet controllers and provides an interface with the
xMDIO bus.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---

@Dave: this patch should go through the mvebu tree as asked by Gregory, thanks!

 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 8 ++++++++
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 037ed30d75a7..464c41d0e66a 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -98,6 +98,14 @@
 				clocks = <&cpm_syscon0 1 9>, <&cpm_syscon0 1 5>;
 			};
 
+			cpm_xmdio: mdio at 12a600 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "marvell,xmdio";
+				reg = <0x12a600 0x10>;
+				status = "disabled";
+			};
+
 			cpm_icu: interrupt-controller at 1e0000 {
 				compatible = "marvell,cp110-icu"; 
 				reg = <0x1e0000 0x10>;
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 2a99ff8fca2a..bbb603234f30 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -103,6 +103,14 @@
 				clocks = <&cps_syscon0 1 9>, <&cps_syscon0 1 5>;
 			};
 
+			cps_xmdio: mdio at 12a600 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "marvell,xmdio";
+				reg = <0x12a600 0x10>;
+				status = "disabled";
+			};
+
 			cps_icu: interrupt-controller at 1e0000 {
 				compatible = "marvell,cp110-icu";
 				reg = <0x1e0000 0x10>;
-- 
2.9.4
