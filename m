From: linux@rempel-privat.de (Oleksij Rempel)
Date: Sat,  6 May 2017 07:30:38 +0200
Subject: [PATCH v3] arm: dts: sun7i-a20-bananapi: name the GPIO lines
Message-ID: <1494048638-24365-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This names the GPIO lines on the Banana Pi board in accordance with
the A20_Banana_Pi v1.4 Specification.

This will make these line names reflect through to user space
so that they can easily be identified and used with the new
character device ABI.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 91f2e5f..6b326b3 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -178,6 +178,57 @@
 };
 
 &pio {
+	gpio-line-names =
+		/* PA */
+		"ERXD3", "ERXD2", "ERXD1", "ERXD0", "ETXD3",
+			"ETXD2", "ETXD1", "ETXD0",
+		"ERXCK", "ERXERR", "ERXDV", "EMDC", "EMDIO",
+			"ETXEN", "ETXCK", "ECRS",
+		"ECOL", "ETXERR", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* PB */
+		"PMU-SCK", "PMU-SDA", "", "", "", "", "", "",
+		"", "USB0-DRV", "", "", "", "", "", "",
+		"", "", "", "", "SCL", "SDA", "", "",
+		"", "", "", "", "", "", "", "",
+		/* PC */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* PD */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* PE */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* PF */
+		"SD0-D1", "SD0-D0", "SD0-CLK", "SD0-CMD", "SD0-D3",
+			"SD0-D2", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* PG */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* PH */
+		"TXD0", "RXD0", "IO-1", "PH3", "USB0-IDDET", "PH5", "", "",
+		"", "", "SD0-DET", "", "", "", "", "",
+		"", "", "", "", "IO-4", "IO-5", "", "EMAC-PWR-EN",
+		"LED1", "", "", "", "", "", "", "",
+		/* PI */
+		"", "", "", "IO-GCLK", "", "", "", "",
+		"", "", "SPI-CE0", "SPI-CLK", "SPI-MOSI",
+			"SPI-MISO", "SPI-CE1", "",
+		"IO-6", "IO-3", "IO-2", "IO-0", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
-- 
2.7.4
