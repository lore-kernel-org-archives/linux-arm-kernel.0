From: linux@rempel-privat.de (Oleksij Rempel)
Date: Wed,  3 May 2017 09:09:20 +0200
Subject: [PATCH v2 resend] arm: dts: sun7i-a20-bananapi: name the GPIO lines
In-Reply-To: <CACRpkdZcnJ1eCNW4ZF_A4zbeCt3JcAuw-1meB_Pn7ctMy99B_g@mail.gmail.com>
References: <CACRpkdZcnJ1eCNW4ZF_A4zbeCt3JcAuw-1meB_Pn7ctMy99B_g@mail.gmail.com>
Message-ID: <1493795360-18629-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This names the GPIO lines on the Banana Pi board in accordance with
the A20_Banana_Pi v1.4 Specification.

This will make these line names reflect through to userspace
so that they can easily be identified and used with the new
character device ABI.

Some care has been taken to name all lines, not just those used
by the external connectors, also lines that are muxed into some
other function than GPIO: these are named "[FOO]" so that users
can see with lsgpio what all lines are used for.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 91f2e5f..5b3e0ee 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -178,6 +178,66 @@
 };
 
 &pio {
+	/*
+	 * Legend: proper name = the GPIO line is used as GPIO
+	 *         NC = not connected (not routed from the SoC)
+	 *         "[PER]" = pin is muxed for peripheral (not GPIO)
+	 *         "" = no idea, schematic doesn't say, could be
+	 *              unrouted (not connected to any external pin)
+	 *         LSEC = Low Speed External Connector
+	 *         HSEC = High Speed External Connector
+	 */
+	gpio-line-names =
+		/* PA */
+		"[ERXD3]", "[ERXD2]", "[ERXD1]", "[ERXD0]", "[ETXD3]",
+			"[ETXD2]", "[ETXD1]", "[ETXD0]",
+		"[ERXCK]", "[ERXERR]", "[ERXDV]", "[EMDC]", "[EMDIO]",
+			"[ETXEN]", "[ETXCK]", "[ECRS]",
+		"[ECOL]", "[ETXERR]", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* PB */
+		"[PMU-SCK]", "[PMU-SDA]", "", "", "", "NC", "NC", "NC",
+		"NC", "[USB0-DRV]", "NC", "NC", "NC", "NC", "", "",
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
+		"[SD0-D1]", "[SD0-D0]", "[SD0-CLK]", "[SD0-CMD]", "[SD0-D3]",
+			"[SD0-D2]", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* PG */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* PH */
+		"TXD0", "RXD0", "IO-1", "PH3", "[USB0-IDDET]", "PH5", "", "",
+		"", "", "[SD0-DET]", "", "", "", "", "",
+		"NC", "", "", "", "IO-4", "IO-5", "NC", "[EMAC-PWR-EN]",
+		"[LED1]", "NC", "NC", "NC", "", "", "", "",
+		/* PI */
+		"", "", "", "IO-GCLK", "NC", "NC", "NC", "NC",
+		"NC", "NC", "[SPI-CE0]", "[SPI-CLK]", "[SPI-MOSI]",
+			"[SPI-MISO]", "[SPI-CE1]", "NC",
+		"IO-6", "IO-3", "IO-2", "IO-0", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
-- 
2.7.4
