From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 28 Sep 2010 22:13:49 +0200
Subject: [PATCH 5/5] ARM: imx/pca100: only specify i2c device type once
In-Reply-To: <20100928201230.GJ26352@pengutronix.de>
References: <20100928201230.GJ26352@pengutronix.de>
Message-ID: <1285704829-29406-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first argument to I2C_BOARD_INFO is used to assign .type, so it should
not be specified a second time.

For the rtc-pcf8563/pcf8563 entry gcc preferred pcf8563, so did I.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mach-pca100.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 197dbb8..1247ce9 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -192,11 +192,9 @@ static struct i2c_board_info pca100_i2c_devices[] = {
 		I2C_BOARD_INFO("at24", 0x52), /* E0=0, E1=1, E2=0 */
 		.platform_data = &board_eeprom,
 	}, {
-		I2C_BOARD_INFO("rtc-pcf8563", 0x51),
-		.type = "pcf8563"
+		I2C_BOARD_INFO("pcf8563", 0x51),
 	}, {
 		I2C_BOARD_INFO("lm75", 0x4a),
-		.type = "lm75"
 	}
 };
 
-- 
1.7.2.3
