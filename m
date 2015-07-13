From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 13 Jul 2015 13:18:51 +0200
Subject: [PATCH] serial: samsung: Remove redundant DEBUG_LL check
Message-ID: <1436786331-5188-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 84f57d9e3685 ("tty: serial/samsung: fix modular build") fixed
build issues when the driver was built as a module. One of those was
that printascii is only accessible when the driver is built-in.

But there is no need to check for defined(CONFIG_DEBUG_LL) since the
SERIAL_SAMSUNG_DEBUG Kconfig symbol already depends on DEBUG_LL.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/tty/serial/samsung.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 67d0c213b1c7..8c963d6d9074 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -53,7 +53,6 @@
 #include "samsung.h"
 
 #if	defined(CONFIG_SERIAL_SAMSUNG_DEBUG) &&	\
-	defined(CONFIG_DEBUG_LL) &&		\
 	!defined(MODULE)
 
 extern void printascii(const char *);
-- 
2.4.3
