From: labbott@redhat.com (Laura Abbott)
Date: Tue,  7 Mar 2017 12:55:28 -0800
Subject: [PATCHv3 11/16] module: Use set_memory.h header
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Message-ID: <1488920133-27229-12-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Acked-by: Jessica Yu <jeyu@redhat.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: #ifdef protection
---
 kernel/module.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 7eba6de..992a100 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -49,6 +49,9 @@
 #include <linux/rculist.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
+#ifdef CONFIG_STRICT_MODULE_RWX
+#include <asm/set_memory.h>
+#endif
 #include <asm/mmu_context.h>
 #include <linux/license.h>
 #include <asm/sections.h>
-- 
2.7.4
