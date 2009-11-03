From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  3 Nov 2009 20:03:19 +0100
Subject: [PATCH 1/2] [ARM] i2c/pxa: remove unused macro
Message-ID: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit

	beea494 ([ARM] Remove EEPROM slave emulation from i2c-pxa driver.)

removed all uses of eedbg, so the definition can go, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: Roel Kluin <roel.kluin@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
---
 drivers/i2c/busses/i2c-pxa.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 0495557..40052c0 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -216,8 +216,6 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2c, int lno, const char *fname)
 #define decode_ICR(val) do { } while (0)
 #endif
 
-#define eedbg(lvl, x...) do { if ((lvl) < 1) { printk(KERN_DEBUG "" x); } } while(0)
-
 static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
 static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
 
-- 
1.6.5.2
