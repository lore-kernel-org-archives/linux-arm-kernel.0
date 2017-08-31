From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 31 Aug 2017 15:52:23 +0200
Subject: [PATCH v3 6/9] ARM64: dts: meson-gxl: libretech-cc: enable high speed
 modes
In-Reply-To: <20170831135226.19784-1-jbrunet@baylibre.com>
References: <20170831135226.19784-1-jbrunet@baylibre.com>
Message-ID: <20170831135226.19784-7-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sdcard UHS modes up to SDR50. Unfortunately, it seems the PCB of
the libretech-cc cannot handle SDR104 at 200Mhz reliably.
Also enable eMMC DDR52 mode.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 7d252168c2fa..64c54c92e214 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -205,6 +205,9 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	disable-wp;
 
@@ -224,6 +227,7 @@
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-ddr-3_3v;
 	max-frequency = <50000000>;
 	non-removable;
 	disable-wp;
-- 
2.9.5
