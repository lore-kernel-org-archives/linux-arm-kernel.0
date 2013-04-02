From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:04 +0900
Subject: [PATCH 08/30] ARM: shmobile: sh73a0: add irqpin DT nodes
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add DT nodes for the 4 irqpin interrupt controllers on sh73a0. We add them
to sh73a0.dtsi, which is also used by configurations, doing all their
device instantiation from board the .c code. We rely on the fact, that
such configurations don't instantiate devices from the device-tree.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi |   81 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 8a59465..7e71e3a 100644
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
1.7.10.4
