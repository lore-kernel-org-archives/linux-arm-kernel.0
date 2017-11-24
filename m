From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 24 Nov 2017 23:59:45 +0300
Subject: [PATCH 2/2] arm64: dts: renesas: v3msk: add EtherAVB support
Message-ID: <20171124210317.285946395@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the V3M Starter Kit board dependent part of the EtherAVB
device node.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -31,6 +31,17 @@
 	};
 };
 
+&avb {
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+	};
+};
+
 &extal_clk {
 	clock-frequency = <16666666>;
 };
