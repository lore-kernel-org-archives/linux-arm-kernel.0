From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 17 Sep 2009 08:06:00 +0200
Subject: [PATCH v2] arm: mmu fix unused variable highmem when HIGHMEM is not
	enable
In-Reply-To: <alpine.LFD.2.00.0909162216550.24133@xanadu.home>
References: <alpine.LFD.2.00.0909162216550.24133@xanadu.home>
Message-ID: <1253167560-3670-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mm/mmu.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

v2:
Fix stupid typo

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4426ee6..ce77023 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -687,7 +687,10 @@ __early_param("vmalloc=", early_vmalloc);
 
 static void __init sanity_check_meminfo(void)
 {
-	int i, j, highmem = 0;
+	int i, j;
+#ifdef CONFIG_HIGHMEM
+	int highmem = 0;
+#endif
 
 	for (i = 0, j = 0; i < meminfo.nr_banks; i++) {
 		struct membank *bank = &meminfo.bank[j];
-- 
1.6.4
