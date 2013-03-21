From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 21 Mar 2013 17:05:40 +0100 (CET)
Subject: [PATCH 2/3] ARM: shmobile: sh73a0: add irqpin DT nodes
In-Reply-To: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
References: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
Message-ID: <Pine.LNX.4.64.1303211704130.32438@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT nodes for the 4 irqpin interrupt controllers on sh73a0. We add them
to sh73a0.dtsi, which is also used by configurations, doing all their
device instantiation from board the .c code. We rely on the fact, that
such configurations don't instantiate devices from the device-tree.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh73a0.dtsi |   81 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 3e4d383..ec40bf7 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -38,6 +38,87 @@
 		      <0xf0000100 0x100>;
 	};
 
+	irqpin0: irqpin at e6900000 {
+		compatible = "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe6900000 4>,
+			<0xe6900010 4>,
+			<0xe6900020 1>,
+			<0xe6900040 1>,
+			<0xe6900060 1>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 1 0x4
+			      0 2 0x4
+			      0 3 0x4
+			      0 4 0x4
+			      0 5 0x4
+			      0 6 0x4
+			      0 7 0x4
+			      0 8 0x4>;
+	};
+
+	irqpin1: irqpin at e6900004 {
+		compatible = "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe6900004 4>,
+			<0xe6900014 4>,
+			<0xe6900024 1>,
+			<0xe6900044 1>,
+			<0xe6900064 1>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 9 0x4
+			      0 10 0x4
+			      0 11 0x4
+			      0 12 0x4
+			      0 13 0x4
+			      0 14 0x4
+			      0 15 0x4
+			      0 16 0x4>;
+		control-parent;
+	};
+
+	irqpin2: irqpin at e6900008 {
+		compatible = "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe6900008 4>,
+			<0xe6900018 4>,
+			<0xe6900028 1>,
+			<0xe6900048 1>,
+			<0xe6900068 1>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 17 0x4
+			      0 18 0x4
+			      0 19 0x4
+			      0 20 0x4
+			      0 21 0x4
+			      0 22 0x4
+			      0 23 0x4
+			      0 24 0x4>;
+	};
+
+	irqpin3: irqpin at e690000c {
+		compatible = "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe690000c 4>,
+			<0xe690001c 4>,
+			<0xe690002c 1>,
+			<0xe690004c 1>,
+			<0xe690006c 1>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 25 0x4
+			      0 26 0x4
+			      0 27 0x4
+			      0 28 0x4
+			      0 29 0x4
+			      0 30 0x4
+			      0 31 0x4
+			      0 32 0x4>;
+	};
+
 	i2c0: i2c at 0xe6820000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.7.2.5
