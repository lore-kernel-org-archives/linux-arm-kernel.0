From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:17 +0200
Subject: [PATCH 05/38] ARM: dts: sk-rzg1m: add Ether pins
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <51982d8f4722d1bbc2dabd79d4a1acebb90f6357.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the (previously omitted) Ether/PHY pin data to the SK-RZG1M board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts b/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
index 97a066c22003..3d918d106593 100644
--- a/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
+++ b/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
@@ -44,6 +44,16 @@
 		groups = "scif0_data_d";
 		function = "scif0";
 	};
+
+	ether_pins: ether {
+		groups = "eth_link", "eth_mdio", "eth_rmii";
+		function = "eth";
+	};
+
+	phy1_pins: phy1 {
+		groups = "intc_irq0";
+		function = "intc";
+	};
 };
 
 &scif0 {
@@ -54,6 +64,9 @@
 };
 
 &ether {
+	pinctrl-0 = <&ether_pins &phy1_pins>;
+	pinctrl-names = "default";
+
 	phy-handle = <&phy1>;
 	renesas,ether-link-active-low;
 	status = "okay";
-- 
2.1.4
