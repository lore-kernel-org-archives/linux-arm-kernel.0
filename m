From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 13:32:16 +0900
Subject: [PATCH 7/7] ARM: shmobile: marzen-reference: add irqpin support in DT
In-Reply-To: <1370406736-32272-1-git-send-email-horms+renesas@verge.net.au>
References: <1370406736-32272-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370406736-32272-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add an irqpin interrupt controller DT node on marzen-reference.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index fe5c6f2..7f146c6 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -48,6 +48,23 @@
                       <0xf0000100 0x100>;
         };
 
+	irqpin0: irqpin at fe780010 {
+		compatible = "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xfe78001c 4>,
+			<0xfe780010 4>,
+			<0xfe780024 4>,
+			<0xfe780044 4>,
+			<0xfe780064 4>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 27 0x4
+				0 28 0x4
+				0 29 0x4
+				0 30 0x4>;
+		sense-bitfield-width = <2>;
+	};
+
 	i2c0: i2c at 0xffc70000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.2.1
