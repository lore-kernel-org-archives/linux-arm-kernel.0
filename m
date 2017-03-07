From: labbott@redhat.com (Laura Abbott)
Date: Tue,  7 Mar 2017 12:55:25 -0800
Subject: [PATCHv3 08/16] intel_th: Use set_memory.h header
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Message-ID: <1488920133-27229-9-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Add #ifdef CONFIG_X86
---
 drivers/hwtracing/intel_th/msu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index e88afe1..dbbe31d 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -27,7 +27,9 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 
-#include <asm/cacheflush.h>
+#ifdef CONFIG_X86
+#include <asm/set_memory.h>
+#endif
 
 #include "intel_th.h"
 #include "msu.h"
-- 
2.7.4
