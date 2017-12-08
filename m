From: jinb.park7@gmail.com (Jinbum Park)
Date: Fri, 8 Dec 2017 20:13:18 +0900
Subject: [kernel-hardening][PATCH] arm: mm: idmap: Mark variables as
 ro_after_init
Message-ID: <20171208111318.GA12346@pjb1027-Latitude-E5410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

idmap_pgd, arch_phys_to_idmap_offset are setup once
while init stage, and never changed after that.
so, it is good candidate for __ro_after_init.

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
 arch/arm/mm/idmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 10bfba8..1d1edd0 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -16,8 +16,8 @@
  * are not supported on any CPU using the idmap tables as its current
  * page tables.
  */
-pgd_t *idmap_pgd;
-long long arch_phys_to_idmap_offset;
+pgd_t *idmap_pgd __ro_after_init;
+long long arch_phys_to_idmap_offset __ro_after_init;
 
 #ifdef CONFIG_ARM_LPAE
 static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
-- 
1.9.1
