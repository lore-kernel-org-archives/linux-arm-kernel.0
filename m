From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 7 Sep 2013 04:26:12 +0400
Subject: [PATCH v2 1/4] ARM: shmobile: r8a7778: add Ether DT support
In-Reply-To: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
References: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
Message-ID: <201309070426.13099.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7778 part of the Ether device node. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- changed the "compatible" property to "renesas,ether-r8a7778".

 arch/arm/boot/dts/r8a7778.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7778.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7778.dtsi
+++ renesas/arch/arm/boot/dts/r8a7778.dtsi
@@ -98,4 +98,15 @@
 		reg = <0xfffc000 0x118>;
 		#gpio-range-cells = <3>;
 	};
+
+	ether: ethernet at fde00000 {
+		device_type = "network";
+		compatible = "renesas,ether-r8a7778";
+		reg = <0xfde00000 0x400>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 105 0x4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
