From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Mar 2013 18:17:39 +0000
Subject: [PATCH v2 5/5] ARM: modules: don't export cpu_set_pte_ext when !MMU
In-Reply-To: <1364235459-17672-1-git-send-email-will.deacon@arm.com>
References: <1364235459-17672-1-git-send-email-will.deacon@arm.com>
Message-ID: <1364235459-17672-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_set_pte_ext is only guaranteed to be defined when CONFIG_MMU, so
don't export it to modules otherwise.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-syms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/proc-syms.c b/arch/arm/mm/proc-syms.c
index 3e6210b..054b491 100644
--- a/arch/arm/mm/proc-syms.c
+++ b/arch/arm/mm/proc-syms.c
@@ -17,7 +17,9 @@
 
 #ifndef MULTI_CPU
 EXPORT_SYMBOL(cpu_dcache_clean_area);
+#ifdef CONFIG_MMU
 EXPORT_SYMBOL(cpu_set_pte_ext);
+#endif
 #else
 EXPORT_SYMBOL(processor);
 #endif
-- 
1.8.0
