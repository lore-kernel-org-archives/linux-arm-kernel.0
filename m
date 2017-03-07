From: labbott@redhat.com (Laura Abbott)
Date: Tue,  7 Mar 2017 12:55:19 -0800
Subject: [PATCHv3 02/16] arm: Use set_memory.h header
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Message-ID: <1488920133-27229-3-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Add one file, keep the cacheflush.h header in bpf
---
 arch/arm/kernel/ftrace.c        | 1 +
 arch/arm/kernel/machine_kexec.c | 1 +
 arch/arm/mm/pageattr.c          | 1 +
 arch/arm/net/bpf_jit_32.c       | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 3f17594..dea3e96 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -21,6 +21,7 @@
 #include <asm/opcodes.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
+#include <asm/set_memory.h>
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define	NOP		0xf85deb04	/* pop.w {lr} */
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index b18c1ea..1549588 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -18,6 +18,7 @@
 #include <asm/mach-types.h>
 #include <asm/smp_plat.h>
 #include <asm/system_misc.h>
+#include <asm/set_memory.h>
 
 extern void relocate_new_kernel(void);
 extern const unsigned int relocate_new_kernel_size;
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
index 93d0b6d..d5b9fa1 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -18,6 +18,7 @@
 #include <linux/if_vlan.h>
 
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/hwcap.h>
 #include <asm/opcodes.h>
 
-- 
2.7.4
