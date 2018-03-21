From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 21 Mar 2018 11:50:04 +0100
Subject: [PATCH 2/3] arm64: dts: armada-3720-espressobin: make use of switch
 irq line
In-Reply-To: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
References: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20180321105005.18426-2-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The switch's INTn line is connected to the CPU's MPP2_23 pad. Wire this
up in the device tree. Note however that up to now the
marvell,armada3710-sb-pinctrl driver doesn't support level irqs, so the
switch driver doesn't make use of this feature.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 6d070b267abe..a88f053d2f28 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -133,6 +133,11 @@
 		#size-cells = <0>;
 		reg = <1>;
 
+		interrupt-parent = <&gpiosb>;
+		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		dsa,member = <0 0>;
 
 		ports {
@@ -171,12 +176,20 @@
 
 			switch0phy0: switch0phy0 at 11 {
 				reg = <0x11>;
+				interrupt-parent = <&switch0>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 			};
+
 			switch0phy1: switch0phy1 at 12 {
 				reg = <0x12>;
+				interrupt-parent = <&switch0>;
+				interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 			};
+
 			switch0phy2: switch0phy2 at 13 {
 				reg = <0x13>;
+				interrupt-parent = <&switch0>;
+				interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 	};
-- 
2.16.2
