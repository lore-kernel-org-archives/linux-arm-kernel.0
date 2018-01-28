From: embed3d@gmail.com (Philipp Rossak)
Date: Mon, 29 Jan 2018 00:29:14 +0100
Subject: [PATCH v2 11/16] arm: dts: sunxi-h3-h5: add support for the thermal
 sensor in H3 and H5
In-Reply-To: <20180128232919.12639-1-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
Message-ID: <20180128232919.12639-12-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have gained the support for the thermal sensor in H3 and H5,
we can now add its device nodes to the device tree. The H3 and H5 share
most of its compatible. The compatible and the thermal sensor cells
will be added in an additional patch per device.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 7a83b15225c7..413c789b588d 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -426,6 +426,15 @@
 			};
 		};
 
+		ths: thermal-sensor at 1c25000 {
+			reg = <0x01c25000 0x100>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_THS>;
+			#io-channel-cells = <0>;
+		};
+
 		timer at 1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
-- 
2.11.0
