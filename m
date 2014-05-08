From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 08 May 2014 15:13:47 -0600
Subject: [PATCH] arm64: Make atomic64_t() return "long", not "long long"
Message-ID: <20140508211347.18358.8154.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 sets CONFIG_64BIT=y and hence uses the "long counter" atomic64_t
definition from include/linux/types.h.  Make atomic64_read() return "long",
not "long long".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/include/asm/atomic.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 0237f0867e37..9c48d74652cb 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -162,7 +162,7 @@ static inline int __atomic_add_unless(atomic_t *v, int a, int u)
  */
 #define ATOMIC64_INIT(i) { (i) }
 
-#define atomic64_read(v)	(*(volatile long long *)&(v)->counter)
+#define atomic64_read(v)	(*(volatile long *)&(v)->counter)
 #define atomic64_set(v,i)	(((v)->counter) = (i))
 
 static inline void atomic64_add(u64 i, atomic64_t *v)
