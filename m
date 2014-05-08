From: robherring2@gmail.com (Rob Herring)
Date: Thu,  8 May 2014 17:23:43 -0500
Subject: [PATCH 6/6] tty/serial: pl011: add DT based earlycon support
In-Reply-To: <1399587823-17701-1-git-send-email-robherring2@gmail.com>
References: <1399587823-17701-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399587823-17701-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Enable DT based earlycon initialization for the pl011 uart.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/amba-pl011.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index ee3d803..908a6e3 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2072,6 +2072,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 EARLYCON_DECLARE(pl011, pl011_early_console_setup);
+OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
 
 #else
 #define AMBA_CONSOLE	NULL
-- 
1.9.1
