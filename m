From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 21 Mar 2018 11:50:03 +0100
Subject: [PATCH 1/3] arm64: dts: marvell: armada-37xx: mark the gpio
 controllers as irq controller
Message-ID: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to reference these gpio controller as interrupt parent. Also
add a comment which cpu line names are managed by the controllers
because "nb" and "sb" usually doesn't appear in schematics, but MPPX_Y
do.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 375026867342..6a96404e7c88 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -184,10 +184,13 @@
 				compatible = "marvell,armada3710-nb-pinctrl",
 					     "syscon", "simple-mfd";
 				reg = <0x13800 0x100>, <0x13C00 0x20>;
+				/* MPP1[19:0] */
 				gpionb: gpio {
 					#gpio-cells = <2>;
 					gpio-ranges = <&pinctrl_nb 0 0 36>;
 					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
 					interrupts =
 					<GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
@@ -245,10 +248,13 @@
 				compatible = "marvell,armada3710-sb-pinctrl",
 					     "syscon", "simple-mfd";
 				reg = <0x18800 0x100>, <0x18C00 0x20>;
+				/* MPP2[23:0] */
 				gpiosb: gpio {
 					#gpio-cells = <2>;
 					gpio-ranges = <&pinctrl_sb 0 0 30>;
 					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
 					interrupts =
 					<GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.16.2
