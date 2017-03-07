From: labbott@redhat.com (Laura Abbott)
Date: Tue,  7 Mar 2017 12:55:26 -0800
Subject: [PATCHv3 09/16] watchdog: hpwdt: Use set_memory.h header
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Message-ID: <1488920133-27229-10-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: No changes
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 70c7194..67fbe35 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -34,7 +34,7 @@
 #include <linux/nmi.h>
 #include <linux/kdebug.h>
 #include <linux/notifier.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #endif /* CONFIG_HPWDT_NMI_DECODING */
 #include <asm/nmi.h>
 #include <asm/frame.h>
-- 
2.7.4
