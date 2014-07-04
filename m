From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 04 Jul 2014 19:48:04 +0200
Subject: [PATCH 04/19] serial: samsung: Remove support for legacy clock code
In-Reply-To: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
Message-ID: <1404496099-26708-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Samsung platforms are now using the Common Clock Framework and the
legacy clock code is being removed, so remove related dead code from
samsung-serial driver as well.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:SERIAL DRIVERS)
Cc: Jiri Slaby <jslaby@suse.cz> (supporter:TTY LAYER)
Cc: linux-serial at vger.kernel.org (open list:SERIAL DRIVERS)
---
 drivers/tty/serial/samsung.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 36c7747..cae8ebd 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -47,10 +47,6 @@
 
 #include <asm/irq.h>
 
-#ifdef CONFIG_SAMSUNG_CLOCK
-#include <plat/clock.h>
-#endif
-
 #include "samsung.h"
 
 #if	defined(CONFIG_SERIAL_SAMSUNG_DEBUG) &&	\
-- 
1.9.3
