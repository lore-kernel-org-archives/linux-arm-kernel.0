From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 21 Mar 2018 11:50:05 +0100
Subject: [PATCH 3/3] arm64: dts: armada-3720-espressobin: wire up LED2
In-Reply-To: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
References: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20180321105005.18426-3-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The led is connected to MPP1_2.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Note the LED doesn't work for me on two different boards. But the
voltage levels on one side of the LED changes from 1.76V to 0V when
enabling the LED. So there is probably something fishy, don't know if it
is hardware or software related.

Best regards
Uwe
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index a88f053d2f28..0802d595e0a2 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -77,6 +77,15 @@
 			  3300000 0x0>;
 		enable-active-high;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led2 {
+			gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
 };
 
 /* J9 */
-- 
2.16.2
