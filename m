From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 13 Oct 2009 09:19:48 +0200
Subject: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
In-Reply-To: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1255418388-27866-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a compile error introduced in

	6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)

That commit moved arch/arm/include/asm/mach/mmc.h to
include/linux/amba/mmci.h.  Just removing the include was enough.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Bill Gatliff <bgat@billgatliff.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Pierre Ossman <drzeus@drzeus.cx>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Hello,

what is the right path to Linus for this patch?

Best regards
Uwe

 drivers/mmc/host/at91_mci.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index e556d42..63924e0 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -72,7 +72,6 @@
 #include <asm/irq.h>
 #include <asm/gpio.h>
 
-#include <asm/mach/mmc.h>
 #include <mach/board.h>
 #include <mach/cpu.h>
 #include <mach/at91_mci.h>
-- 
1.6.4.3
