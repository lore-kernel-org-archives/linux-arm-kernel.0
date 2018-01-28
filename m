From: embed3d@gmail.com (Philipp Rossak)
Date: Mon, 29 Jan 2018 00:29:18 +0100
Subject: [PATCH v2 15/16] arm: dts: sun8i: a83t: add support for the thermal
 sensor in A83T
In-Reply-To: <20180128232919.12639-1-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
Message-ID: <20180128232919.12639-16-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have gained the support for the thermal sensor in A83T,
we can now add its device nodes to the device tree.

The A83T seems to have a broken IRQ 31, thus we use here IRQ 41.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 7f4955a5fab7..9e53ff5ac4ed 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -518,6 +518,14 @@
 			clocks = <&osc24M>;
 		};
 
+		ths: thermal-sensor at 1f04000 {
+			compatible = "allwinner,sun8i-a83t-ths";
+			reg = <0x01f04000 0x100>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <1>;
+			#io-channel-cells = <0>;
+		};
+
 		watchdog at 1c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
-- 
2.11.0
