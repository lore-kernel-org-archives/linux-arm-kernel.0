From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 26 Jul 2018 01:35:21 +0100
Subject: [PATCH v2 07/18] arm64: dts: allwinner: a64: Orange Pi Win: Add LED
 node
In-Reply-To: <20180726003532.18751-1-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
Message-ID: <20180726003532.18751-8-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samuel Holland <samuel@sholland.org>

The Orange Pi Win has a green status LED, add the DT node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 10f63d0b99cb..55eea0b077d0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -64,6 +64,15 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		status {
+			label = "orangepi:green:status";
+			gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+		};
+	};
+
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "gmac-3v3";
-- 
2.14.4
