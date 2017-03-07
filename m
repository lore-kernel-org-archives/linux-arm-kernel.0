From: labbott@redhat.com (Laura Abbott)
Date: Tue,  7 Mar 2017 12:55:31 -0800
Subject: [PATCHv3 14/16] misc: sram: Use set_memory.h header
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Message-ID: <1488920133-27229-15-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
V3: New file which was not caught in the first pass.
---
 drivers/misc/sram-exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
index ac52241..3d528a1 100644
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -16,9 +16,10 @@
 
 #include <linux/device.h>
 #include <linux/genalloc.h>
+#include <linux/mm.h>
 #include <linux/sram.h>
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include "sram.h"
 
-- 
2.7.4
