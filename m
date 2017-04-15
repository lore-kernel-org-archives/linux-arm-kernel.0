From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 15 Apr 2017 23:18:28 +0300
Subject: [PATCH 3/3] ARM: dts: sk-rzg1e: add Ether pins
Message-ID: <20170415202044.157568901@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) Ether/PHY pin data to the SK-RZG1E board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
+++ renesas/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
@@ -39,6 +39,16 @@
 		groups = "scif2_data";
 		function = "scif2";
 	};
+
+	ether_pins: ether {
+		groups = "eth_link", "eth_mdio", "eth_rmii";
+		function = "eth";
+	};
+
+	phy1_pins: phy1 {
+		groups = "intc_irq8";
+		function = "intc";
+	};
 };
 
 &scif2 {
@@ -49,6 +59,9 @@
 };
 
 &ether {
+	pinctrl-0 = <&ether_pins &phy1_pins>;
+	pinctrl-names = "default";
+
 	phy-handle = <&phy1>;
 	renesas,ether-link-active-low;
 	status = "okay";
