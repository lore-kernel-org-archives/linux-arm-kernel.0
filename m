From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  2 Jun 2015 11:37:48 +0200
Subject: [PATCH v3 2/3] pinctrl: berlin: comment the spi functions
In-Reply-To: <1433237869-3762-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1433237869-3762-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1433237869-3762-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add comments for the SPI functions, to distinguish CLK, SDI, SDO and
C{0,1,2,3}n.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/berlin/berlin-bg2.c   | 18 +++++++++---------
 drivers/pinctrl/berlin/berlin-bg2cd.c |  8 ++++----
 drivers/pinctrl/berlin/berlin-bg2q.c  | 16 ++++++++--------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg2.c b/drivers/pinctrl/berlin/berlin-bg2.c
index 3769eaedf519..274c5535b531 100644
--- a/drivers/pinctrl/berlin/berlin-bg2.c
+++ b/drivers/pinctrl/berlin/berlin-bg2.c
@@ -20,24 +20,24 @@
 static const struct berlin_desc_group berlin2_soc_pinctrl_groups[] = {
 	/* G */
 	BERLIN_PINCTRL_GROUP("G0", 0x00, 0x1, 0x00,
-		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"),
+		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SS0n */
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
 	BERLIN_PINCTRL_GROUP("G1", 0x00, 0x2, 0x01,
-		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"),
+		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SS1n */
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "usb1")),
 	BERLIN_PINCTRL_GROUP("G2", 0x00, 0x2, 0x02,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-		BERLIN_PINCTRL_FUNCTION(0x1, "spi1"),
+		BERLIN_PINCTRL_FUNCTION(0x1, "spi1"), /* SS2n */
 		BERLIN_PINCTRL_FUNCTION(0x2, "pwm"),
 		BERLIN_PINCTRL_FUNCTION(0x3, "i2s0")),
 	BERLIN_PINCTRL_GROUP("G3", 0x00, 0x2, 0x04,
 		BERLIN_PINCTRL_FUNCTION(0x0, "soc"),
-		BERLIN_PINCTRL_FUNCTION(0x1, "spi1"),
+		BERLIN_PINCTRL_FUNCTION(0x1, "spi1"), /* SS3n */
 		BERLIN_PINCTRL_FUNCTION(0x2, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x3, "i2s1")),
 	BERLIN_PINCTRL_GROUP("G4", 0x00, 0x2, 0x06,
-		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"),
+		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* CLK/SDI/SDO */
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "pwm")),
 	BERLIN_PINCTRL_GROUP("G5", 0x00, 0x3, 0x08,
@@ -163,15 +163,15 @@ static const struct berlin_desc_group berlin2_sysmgr_pinctrl_groups[] = {
 	/* GSM */
 	BERLIN_PINCTRL_GROUP("GSM0", 0x40, 0x2, 0x00,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-		BERLIN_PINCTRL_FUNCTION(0x1, "spi2"),
+		BERLIN_PINCTRL_FUNCTION(0x1, "spi2"), /* SS0n */
 		BERLIN_PINCTRL_FUNCTION(0x2, "eth1")),
 	BERLIN_PINCTRL_GROUP("GSM1", 0x40, 0x2, 0x02,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-		BERLIN_PINCTRL_FUNCTION(0x1, "spi2"),
+		BERLIN_PINCTRL_FUNCTION(0x1, "spi2"), /* SS1n */
 		BERLIN_PINCTRL_FUNCTION(0x2, "eth1")),
 	BERLIN_PINCTRL_GROUP("GSM2", 0x40, 0x2, 0x04,
 		BERLIN_PINCTRL_FUNCTION(0x0, "twsi2"),
-		BERLIN_PINCTRL_FUNCTION(0x1, "spi2")),
+		BERLIN_PINCTRL_FUNCTION(0x1, "spi2")), /* SS2n/SS3n */
 	BERLIN_PINCTRL_GROUP("GSM3", 0x40, 0x2, 0x06,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "uart0"),	/* CTS/RTS */
@@ -187,7 +187,7 @@ static const struct berlin_desc_group berlin2_sysmgr_pinctrl_groups[] = {
 		BERLIN_PINCTRL_FUNCTION(0x3, "twsi3")),
 	BERLIN_PINCTRL_GROUP("GSM6", 0x40, 0x2, 0x0c,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-		BERLIN_PINCTRL_FUNCTION(0x1, "spi2"),
+		BERLIN_PINCTRL_FUNCTION(0x1, "spi2"), /* CLK/SDO */
 		BERLIN_PINCTRL_FUNCTION(0x1, "clki")),
 	BERLIN_PINCTRL_GROUP("GSM7", 0x40, 0x1, 0x0e,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
diff --git a/drivers/pinctrl/berlin/berlin-bg2cd.c b/drivers/pinctrl/berlin/berlin-bg2cd.c
index 5cfadbc14a79..0cb793a3552a 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -68,17 +68,17 @@ static const struct berlin_desc_group berlin2cd_soc_pinctrl_groups[] = {
 		BERLIN_PINCTRL_FUNCTION(0x1, "twsi1"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "gpio")),
 	BERLIN_PINCTRL_GROUP("G8", 0x00, 0x3, 0x10,
-		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"),
+		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SS0n */
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
 	BERLIN_PINCTRL_GROUP("G9", 0x00, 0x3, 0x13,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-		BERLIN_PINCTRL_FUNCTION(0x1, "spi1"),
+		BERLIN_PINCTRL_FUNCTION(0x1, "spi1"), /* SS1n/SS2n */
 		BERLIN_PINCTRL_FUNCTION(0x2, "twsi0")),
 	BERLIN_PINCTRL_GROUP("G10", 0x00, 0x2, 0x16,
-		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"),
+		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* CLK */
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
 	BERLIN_PINCTRL_GROUP("G11", 0x00, 0x2, 0x18,
-		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"),
+		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SDI/SDO */
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
 	BERLIN_PINCTRL_GROUP("G12", 0x00, 0x3, 0x1a,
 		BERLIN_PINCTRL_FUNCTION(0x0, "usb1"),
diff --git a/drivers/pinctrl/berlin/berlin-bg2q.c b/drivers/pinctrl/berlin/berlin-bg2q.c
index ba7a8a8ad010..a466054a8206 100644
--- a/drivers/pinctrl/berlin/berlin-bg2q.c
+++ b/drivers/pinctrl/berlin/berlin-bg2q.c
@@ -59,21 +59,21 @@ static const struct berlin_desc_group berlin2q_soc_pinctrl_groups[] = {
 			BERLIN_PINCTRL_FUNCTION(0x2, "gpio"),
 			BERLIN_PINCTRL_FUNCTION(0x3, "eddc")),
 	BERLIN_PINCTRL_GROUP("G8", 0x18, 0x3, 0x18,
-			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"),
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* CLK/SDI/SDO */
 			BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
 	BERLIN_PINCTRL_GROUP("G9", 0x18, 0x3, 0x1b,
-			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"),
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SS0n/SS1n */
 			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"),
 			BERLIN_PINCTRL_FUNCTION(0x5, "sata")),
 	BERLIN_PINCTRL_GROUP("G10", 0x1c, 0x3, 0x00,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-			BERLIN_PINCTRL_FUNCTION(0x1, "spi1"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "spi1"), /* SS2n */
 			BERLIN_PINCTRL_FUNCTION(0x3, "i2s0"),
 			BERLIN_PINCTRL_FUNCTION(0x4, "pwm"),
 			BERLIN_PINCTRL_FUNCTION(0x5, "sata")),
 	BERLIN_PINCTRL_GROUP("G11", 0x1c, 0x3, 0x03,
 			BERLIN_PINCTRL_FUNCTION(0x0, "jtag"),
-			BERLIN_PINCTRL_FUNCTION(0x1, "spi1"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "spi1"), /* SS3n */
 			BERLIN_PINCTRL_FUNCTION(0x2, "gpio"),
 			BERLIN_PINCTRL_FUNCTION(0x3, "i2s1"),
 			BERLIN_PINCTRL_FUNCTION(0x4, "pwm"),
@@ -301,19 +301,19 @@ static const struct berlin_desc_group berlin2q_sysmgr_pinctrl_groups[] = {
 	/* GSM */
 	BERLIN_PINCTRL_GROUP("GSM0", 0x40, 0x2, 0x00,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-			BERLIN_PINCTRL_FUNCTION(0x1, "spi2"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "spi2"), /* SS0n */
 			BERLIN_PINCTRL_FUNCTION(0x2, "eth1")),
 	BERLIN_PINCTRL_GROUP("GSM1", 0x40, 0x2, 0x02,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-			BERLIN_PINCTRL_FUNCTION(0x1, "spi2"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "spi2"), /* SS1n */
 			BERLIN_PINCTRL_FUNCTION(0x2, "eth1")),
 	BERLIN_PINCTRL_GROUP("GSM2", 0x40, 0x2, 0x04,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-			BERLIN_PINCTRL_FUNCTION(0x1, "spi2"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "spi2"), /* SS2n/SS3n */
 			BERLIN_PINCTRL_FUNCTION(0x2, "eddc")),
 	BERLIN_PINCTRL_GROUP("GSM3", 0x40, 0x2, 0x06,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-			BERLIN_PINCTRL_FUNCTION(0x1, "spi2"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "spi2"), /* CLK/SDO */
 			BERLIN_PINCTRL_FUNCTION(0x2, "eddc")),
 	BERLIN_PINCTRL_GROUP("GSM4", 0x40, 0x1, 0x08,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-- 
2.4.2
