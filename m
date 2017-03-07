From: labbott@redhat.com (Laura Abbott)
Date: Tue,  7 Mar 2017 12:55:29 -0800
Subject: [PATCHv3 12/16] PM / hibernate: Use set_memory.h header
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Message-ID: <1488920133-27229-13-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: #ifdef protection
---
 kernel/power/snapshot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d79a38d..3b1e0f3 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -36,6 +36,9 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/io.h>
+#ifdef CONFIG_STRICT_KERNEL_RWX
+#include <asm/set_memory.h>
+#endif
 
 #include "power.h"
 
-- 
2.7.4
