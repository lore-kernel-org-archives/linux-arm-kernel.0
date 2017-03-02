From: labbott@redhat.com (Laura Abbott)
Date: Wed,  1 Mar 2017 16:14:54 -0800
Subject: [PATCHv2 02/14] arm: Use set_memory.h header
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Message-ID: <1488413706-9739-3-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/arm/mm/pageattr.c    | 1 +
 arch/arm/net/bpf_jit_32.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index 3b69f26..1403cb4 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -15,6 +15,7 @@
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
+#include <asm/set_memory.h>
 
 struct page_change_data {
 	pgprot_t set_mask;
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 93d0b6d..c200910 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 #include <linux/if_vlan.h>
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/hwcap.h>
 #include <asm/opcodes.h>
 
-- 
2.7.4
