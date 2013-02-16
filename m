From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 17 Feb 2013 01:40:45 +0300
Subject: [PATCH 1/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
Message-ID: <201302170140.45708.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Allow configuration of the r8a7779 SoC SATA controller using a flattened device
tree.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7779.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7779.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7779.dtsi
+++ renesas/arch/arm/boot/dts/r8a7779.dtsi
@@ -92,4 +92,11 @@
 		interrupts = <0 28 0x4>;
 		reg-io-width = <4>;
 	};
+
+	sata: sata at 0xfc600000 {
+		compatible = "renesas,rcar-sata";
+		reg = <0xfc600000 0x2000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 100 0x4>;
+	};
 };
