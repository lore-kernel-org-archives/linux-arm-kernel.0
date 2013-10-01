From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 17:12:29 +0900
Subject: [PATCH 04/10] ARM: shmobile: r8a7791 IRQC device tree node
In-Reply-To: <20131001081143.4136.46925.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
Message-ID: <20131001081229.4136.10506.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable a r8a7791 IRQC block by adding a device tree
node for the IRQC hardware and pins IRQ0 to IRQ9.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7791.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-10-01 16:29:00.000000000 +0900
@@ -38,4 +38,22 @@
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
 	};
+
+	irqc0: interrupt-controller at e61c0000 {
+		compatible = "renesas,irqc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0 0xe61c0000 0 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 0 4>,
+			      <0 1 4>,
+			      <0 2 4>,
+			      <0 3 4>,
+			      <0 12 4>,
+			      <0 13 4>,
+			      <0 14 4>,
+			      <0 15 4>,
+			      <0 16 4>,
+			      <0 17 4>;
+	};
 };
