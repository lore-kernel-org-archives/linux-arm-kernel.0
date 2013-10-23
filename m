From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 15:08:48 +0200
Subject: [PATCH] ARM: nommu: Implement dummy early_paging_init()
Message-ID: <1382533728-19495-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No-MMU configurations currenty fail to build because they are missing
the early_paging_init() symbol.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mm/nommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 34d4ab2..5c668b7 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -296,6 +296,15 @@ void __init sanity_check_meminfo(void)
 }
 
 /*
+ * early_paging_init() recreates boot time page table setup, allowing machines
+ * to switch over to a high (>4G) address space on LPAE systems
+ */
+void __init early_paging_init(const struct machine_desc *mdesc,
+			      struct proc_info_list *procinfo)
+{
+}
+
+/*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps, and sets up the zero page, bad page and bad page tables.
  */
-- 
1.8.4
