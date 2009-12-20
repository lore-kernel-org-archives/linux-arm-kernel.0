From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 20 Dec 2009 22:10:34 +0100
Subject: [PATCH] pcmcia/at91_cf: don't redefine SZ_2K
Message-ID: <1261343434-3920-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:

	drivers/pcmcia/at91_cf.c:55:1: warning: "SZ_2K" redefined

Since

	c1191b0 ([ARM] Kirkwood: create a mapping for the Security Accelerator SRAM)

SZ_2K is defined in arch/arm/include/asm/sizes.h.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/pcmcia/at91_cf.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index e1dcced..5d22807 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -52,8 +52,6 @@ struct at91_cf_socket {
 	unsigned long		phys_baseaddr;
 };
 
-#define	SZ_2K			(2 * SZ_1K)
-
 static inline int at91_cf_present(struct at91_cf_socket *cf)
 {
 	return !gpio_get_value(cf->board->det_pin);
-- 
1.6.5.2
