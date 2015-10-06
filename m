From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  6 Oct 2015 22:56:37 +0200
Subject: [PATCH RESEND] pinctrl: berlin: fix BG2CD field widths
In-Reply-To: <CACRpkdaYGUkq-QqCtzph-aoYOzCfCgQ5JSAcNDjBeBLoZ0i_iA@mail.gmail.com>
References: <CACRpkdaYGUkq-QqCtzph-aoYOzCfCgQ5JSAcNDjBeBLoZ0i_iA@mail.gmail.com>
Message-ID: <1444164997-7746-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Hebb <tommyhebb@gmail.com>

The previous register layout was incorrect, many of the fields having
fewer bits than were needed to represent all their modes. The new layout
is taken from the bootloader source of a BG2CD device.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Linus,

this is the fix from Thomas rebased on v4.3-rc1.

Sebastian
---
 drivers/pinctrl/berlin/berlin-bg2cd.c | 62 ++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg2cd.c b/drivers/pinctrl/berlin/berlin-bg2cd.c
index 0cb793a3552a..af5e465739ca 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -19,24 +19,24 @@
 
 static const struct berlin_desc_group berlin2cd_soc_pinctrl_groups[] = {
 	/* G */
-	BERLIN_PINCTRL_GROUP("G0", 0x00, 0x1, 0x00,
+	BERLIN_PINCTRL_GROUP("G0", 0x00, 0x3, 0x00,
 		BERLIN_PINCTRL_FUNCTION(0x0, "jtag"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "led"),
 		BERLIN_PINCTRL_FUNCTION(0x3, "pwm")),
-	BERLIN_PINCTRL_GROUP("G1", 0x00, 0x2, 0x01,
+	BERLIN_PINCTRL_GROUP("G1", 0x00, 0x3, 0x03,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "sd0"),
 		BERLIN_PINCTRL_FUNCTION(0x6, "usb0_dbg"),
 		BERLIN_PINCTRL_FUNCTION(0x7, "usb1_dbg")),
-	BERLIN_PINCTRL_GROUP("G2", 0x00, 0x2, 0x02,
+	BERLIN_PINCTRL_GROUP("G2", 0x00, 0x3, 0x06,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "sd0"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "fe"),
 		BERLIN_PINCTRL_FUNCTION(0x3, "pll"),
 		BERLIN_PINCTRL_FUNCTION(0x6, "usb0_dbg"),
 		BERLIN_PINCTRL_FUNCTION(0x7, "usb1_dbg")),
-	BERLIN_PINCTRL_GROUP("G3", 0x00, 0x2, 0x04,
+	BERLIN_PINCTRL_GROUP("G3", 0x00, 0x3, 0x09,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "sd0"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "twsi2"),
@@ -44,7 +44,7 @@ static const struct berlin_desc_group berlin2cd_soc_pinctrl_groups[] = {
 		BERLIN_PINCTRL_FUNCTION(0x4, "fe"),
 		BERLIN_PINCTRL_FUNCTION(0x6, "usb0_dbg"),
 		BERLIN_PINCTRL_FUNCTION(0x7, "usb1_dbg")),
-	BERLIN_PINCTRL_GROUP("G4", 0x00, 0x2, 0x06,
+	BERLIN_PINCTRL_GROUP("G4", 0x00, 0x3, 0x0c,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "sd0"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "twsi3"),
@@ -52,7 +52,7 @@ static const struct berlin_desc_group berlin2cd_soc_pinctrl_groups[] = {
 		BERLIN_PINCTRL_FUNCTION(0x4, "pwm"),
 		BERLIN_PINCTRL_FUNCTION(0x6, "usb0_dbg"),
 		BERLIN_PINCTRL_FUNCTION(0x7, "usb1_dbg")),
-	BERLIN_PINCTRL_GROUP("G5", 0x00, 0x3, 0x08,
+	BERLIN_PINCTRL_GROUP("G5", 0x00, 0x3, 0x0f,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "sd0"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "twsi3"),
@@ -60,64 +60,66 @@ static const struct berlin_desc_group berlin2cd_soc_pinctrl_groups[] = {
 		BERLIN_PINCTRL_FUNCTION(0x4, "pwm"),
 		BERLIN_PINCTRL_FUNCTION(0x6, "usb0_dbg"),
 		BERLIN_PINCTRL_FUNCTION(0x7, "usb1_dbg")),
-	BERLIN_PINCTRL_GROUP("G6", 0x00, 0x2, 0x0b,
+	BERLIN_PINCTRL_GROUP("G6", 0x00, 0x3, 0x12,
 		BERLIN_PINCTRL_FUNCTION(0x0, "uart0"),	/* RX/TX */
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
-	BERLIN_PINCTRL_GROUP("G7", 0x00, 0x3, 0x0d,
+	BERLIN_PINCTRL_GROUP("G7", 0x00, 0x3, 0x15,
 		BERLIN_PINCTRL_FUNCTION(0x0, "eddc"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "twsi1"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "gpio")),
-	BERLIN_PINCTRL_GROUP("G8", 0x00, 0x3, 0x10,
+	BERLIN_PINCTRL_GROUP("G8", 0x00, 0x3, 0x18,
 		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SS0n */
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
-	BERLIN_PINCTRL_GROUP("G9", 0x00, 0x3, 0x13,
+	BERLIN_PINCTRL_GROUP("G9", 0x00, 0x3, 0x1b,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "spi1"), /* SS1n/SS2n */
-		BERLIN_PINCTRL_FUNCTION(0x2, "twsi0")),
-	BERLIN_PINCTRL_GROUP("G10", 0x00, 0x2, 0x16,
+		BERLIN_PINCTRL_FUNCTION(0x3, "twsi0")),
+	BERLIN_PINCTRL_GROUP("G10", 0x00, 0x2, 0x1e,
 		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* CLK */
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
-	BERLIN_PINCTRL_GROUP("G11", 0x00, 0x2, 0x18,
+	BERLIN_PINCTRL_GROUP("G11", 0x04, 0x2, 0x00,
 		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SDI/SDO */
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
-	BERLIN_PINCTRL_GROUP("G12", 0x00, 0x3, 0x1a,
+	BERLIN_PINCTRL_GROUP("G12", 0x04, 0x3, 0x02,
 		BERLIN_PINCTRL_FUNCTION(0x0, "usb1"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
-	BERLIN_PINCTRL_GROUP("G13", 0x04, 0x3, 0x00,
+	BERLIN_PINCTRL_GROUP("G13", 0x04, 0x3, 0x05,
 		BERLIN_PINCTRL_FUNCTION(0x0, "nand"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "usb0_dbg"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "usb1_dbg")),
-	BERLIN_PINCTRL_GROUP("G14", 0x04, 0x1, 0x03,
+	BERLIN_PINCTRL_GROUP("G14", 0x04, 0x1, 0x08,
 		BERLIN_PINCTRL_FUNCTION(0x0, "nand"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
-	BERLIN_PINCTRL_GROUP("G15", 0x04, 0x2, 0x04,
+	BERLIN_PINCTRL_GROUP("G15", 0x04, 0x3, 0x09,
 		BERLIN_PINCTRL_FUNCTION(0x0, "jtag"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
-	BERLIN_PINCTRL_GROUP("G16", 0x04, 0x3, 0x06,
+	BERLIN_PINCTRL_GROUP("G16", 0x04, 0x3, 0x0c,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G17", 0x04, 0x3, 0x09,
+	BERLIN_PINCTRL_GROUP("G17", 0x04, 0x3, 0x0f,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G18", 0x04, 0x1, 0x0c,
+	BERLIN_PINCTRL_GROUP("G18", 0x04, 0x2, 0x12,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G19", 0x04, 0x1, 0x0d,
+	BERLIN_PINCTRL_GROUP("G19", 0x04, 0x2, 0x14,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G20", 0x04, 0x1, 0x0e,
+	BERLIN_PINCTRL_GROUP("G20", 0x04, 0x2, 0x16,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G21", 0x04, 0x3, 0x0f,
+	BERLIN_PINCTRL_GROUP("G21", 0x04, 0x3, 0x18,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G22", 0x04, 0x3, 0x12,
+	BERLIN_PINCTRL_GROUP("G22", 0x04, 0x3, 0x1b,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G23", 0x04, 0x3, 0x15,
+	BERLIN_PINCTRL_GROUP("G23", 0x08, 0x3, 0x00,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G24", 0x04, 0x2, 0x18,
+	BERLIN_PINCTRL_GROUP("G24", 0x08, 0x2, 0x03,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G25", 0x04, 0x2, 0x1a,
+	BERLIN_PINCTRL_GROUP("G25", 0x08, 0x2, 0x05,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G26", 0x04, 0x1, 0x1c,
+	BERLIN_PINCTRL_GROUP("G26", 0x08, 0x1, 0x07,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G27", 0x04, 0x1, 0x1d,
+	BERLIN_PINCTRL_GROUP("G27", 0x08, 0x2, 0x08,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
-	BERLIN_PINCTRL_GROUP("G28", 0x04, 0x2, 0x1e,
+	BERLIN_PINCTRL_GROUP("G28", 0x08, 0x3, 0x0a,
+		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
+	BERLIN_PINCTRL_GROUP("G29", 0x08, 0x3, 0x0d,
 		BERLIN_PINCTRL_FUNCTION_UNKNOWN),
 };
 
-- 
2.1.0
