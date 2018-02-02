From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  3 Feb 2018 02:04:56 +0800
Subject: [PATCH 3/3] ARM: sun8i: v3s: enable Ethernet port on the Lichee Pi
 Zero Dock
In-Reply-To: <20180202180456.60378-1-icenowy@aosc.io>
References: <20180202180456.60378-1-icenowy@aosc.io>
Message-ID: <20180202180456.60378-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Lichee Pi Zero Dock has an Ethernet port connected to the internal
PHY of the V3s SoC.

Enable it in the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index d1311098ea45..9b3465cc0dcd 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -49,12 +49,20 @@
 	compatible = "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
 		     "allwinner,sun8i-v3s";
 
+	aliases {
+		ethernet0 = &emac;
+	};
+
 	leds {
 		/* The LEDs use PG0~2 pins, which conflict with MMC1 */
 		status = "disbaled";
 	};
 };
 
+&emac {
+	status = "okay";
+};
+
 &mmc1 {
 	broken-cd;
 	bus-width = <4>;
-- 
2.15.1
