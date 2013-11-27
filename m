From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 27 Nov 2013 10:38:31 +0100
Subject: [PATCH] tty: atmel_serial: include <mach/hardware.h> explicitly
Message-ID: <1385545111-1256-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiled for at91rm9200 (i.e. ARM) the driver needs among others
the symbol AT91RM9200_BASE_US0 which is defined in
arch/arm/mach-at91/include/mach/at91rm9200.h. This file is included
implicitly via several steps. As ARM's <asm/timex.h> will stop including
<mach/hardware.h> later in this series explicitly include
<mach/hardware.h>

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---

Notes:
    Hello,
    
    I want to send this patch as part of a series dropping <mach/timex.h>
    altogether. So please don't take this patch but only give your Ack if
    you're OK with me sending this patch via arm-soc.
    
    Thanks
    Uwe

 drivers/tty/serial/atmel_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c7d99af..de51964 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -47,6 +47,7 @@
 
 #ifdef CONFIG_ARM
 #include <mach/cpu.h>
+#include <mach/hardware.h>
 #include <asm/gpio.h>
 #endif
 
-- 
1.8.4.2
