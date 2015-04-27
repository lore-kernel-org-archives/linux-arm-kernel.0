From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 27 Apr 2015 18:47:51 -0400
Subject: [PATCH 02/11] arm/mach-keystone: remove legacy __cpuinit sections
 that crept in
In-Reply-To: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
References: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1430174880-27958-3-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We removed __cpuinit support (leaving no-op stubs) quite some time
ago.  However two crept back in as of commit 5eb3da7246a5b2dfac9f38
("ARM: keystone: Switch over to coherent memory address space")

Since we want to clobber the stubs too, get these removed now.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/mach-keystone/platsmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
index 5f46a7cf907b..7f99550cad46 100644
--- a/arch/arm/mach-keystone/platsmp.c
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -40,14 +40,14 @@ static int keystone_smp_boot_secondary(unsigned int cpu,
 }
 
 #ifdef CONFIG_ARM_LPAE
-static void __cpuinit keystone_smp_secondary_initmem(unsigned int cpu)
+static void keystone_smp_secondary_initmem(unsigned int cpu)
 {
 	pgd_t *pgd0 = pgd_offset_k(0);
 	cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);
 	local_flush_tlb_all();
 }
 #else
-static inline void __cpuinit keystone_smp_secondary_initmem(unsigned int cpu)
+static inline void keystone_smp_secondary_initmem(unsigned int cpu)
 {}
 #endif
 
-- 
2.2.1
