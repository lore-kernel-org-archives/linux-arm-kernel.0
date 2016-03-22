From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Tue, 22 Mar 2016 13:46:33 +0300
Subject: [PATCH v5 6/6] serial: pl011: add EARLYCON_DECLARE
In-Reply-To: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1458643595-14719-7-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds definition of early console data for pl011.
It allows setting up an early console with a string passed in
command line or compiled by the ACPI SPCR table handler.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 59b743f..af6f87cf 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2385,6 +2385,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
+EARLYCON_DECLARE(pl011, pl011_early_console_setup);
 
 #else
 #define AMBA_CONSOLE	NULL
-- 
2.7.4
