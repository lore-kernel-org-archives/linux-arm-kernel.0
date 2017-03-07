From: labbott@redhat.com (Laura Abbott)
Date: Tue,  7 Mar 2017 12:55:27 -0800
Subject: [PATCHv3 10/16] bpf: Use set_memory.h header
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Message-ID: <1488920133-27229-11-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: #ifdef guard
---
 include/linux/filter.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0c167fd..8053c38 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -18,7 +18,9 @@
 
 #include <net/sch_generic.h>
 
-#include <asm/cacheflush.h>
+#ifdef CONFIG_ARCH_HAS_SET_MEMORY
+#include <asm/set_memory.h>
+#endif
 
 #include <uapi/linux/filter.h>
 #include <uapi/linux/bpf.h>
-- 
2.7.4
