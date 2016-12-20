From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 20 Dec 2016 13:58:26 +0800
Subject: [PATCH] ARM: dts: sun8i: add a delay after reset xr819 on Orange Pi
 Zero
Message-ID: <20161220055826.30725-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

XR819 seems to need a delay after its reset line to be deasserted,
otherwise it may not respond MMC commands correctly, and fail to
initialize.

Add a 200ms delay in the mmc-pwrseq.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index d18807f73060..b7ca916d871d 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -92,6 +92,7 @@
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>;
+		post-power-on-delay-ms = <200>;
 	};
 };
 
-- 
2.11.0
