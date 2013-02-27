From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 27 Feb 2013 23:34:36 +0300
Subject: [PATCH v4 1/3] ARM: mach-shmobile: r8a7779: SATA DT configuration
Message-ID: <201302272334.36679.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Allow configuration of the r8a7779 SoC SATA controller using a flattened device
tree.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes since v3:
- refreshed against the recent 'next' branch.

Changes since v1:
- removed "0x" from the node name.
 
 arch/arm/boot/dts/r8a7779.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7779.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7779.dtsi
+++ renesas/arch/arm/boot/dts/r8a7779.dtsi
@@ -83,4 +83,11 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 81 0x4>;
 	};
+
+	sata: sata at fc600000 {
+		compatible = "renesas,rcar-sata";
+		reg = <0xfc600000 0x2000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 100 0x4>;
+	};
 };
