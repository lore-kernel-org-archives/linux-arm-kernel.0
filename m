From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 3 Apr 2013 11:19:07 +0200 (CEST)
Subject: [PATCH/RFC 2/2] ARM: shmobile: marzen-reference: add irqpin support
 in DT
In-Reply-To: <Pine.LNX.4.64.1304031103590.10531@axis700.grange>
References: <Pine.LNX.4.64.1304031103590.10531@axis700.grange>
Message-ID: <Pine.LNX.4.64.1304031115250.10531@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an irqpin interrupt controller DT node on marzen-reference.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7779.dtsi |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

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
1.7.2.5
