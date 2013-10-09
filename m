From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:16 +0900
Subject: [PATCH 06/13] ARM: shmobile: r8a7791 IRQC device tree node
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au>
References: <cover.1381298964.git.horms+renesas@verge.net.au>
Message-ID: <d77db73e260fe4b5cca4fa1e5253c21e2d755f58.1381298964.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable a r8a7791 IRQC block by adding a device tree
node for the IRQC hardware and pins IRQ0 to IRQ9.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index bbed43b..b701417 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
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
-- 
1.8.4
