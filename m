From: jinb.park7@gmail.com (Jinbum Park)
Date: Wed, 22 Nov 2017 21:43:59 +0900
Subject: [PATCH] arm64: pgd: Mark pgd_cache as __ro_after_init
Message-ID: <20171122124359.GA4150@pjb1027-Latitude-E5410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pgd_cache is setup once while init stage and never changed after
that, so it is good candidate for __ro_after_init

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
 arch/arm64/mm/pgd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 371c5f0..051e71e 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -26,7 +26,7 @@
 #include <asm/page.h>
 #include <asm/tlbflush.h>
 
-static struct kmem_cache *pgd_cache;
+static struct kmem_cache *pgd_cache __ro_after_init;
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-- 
1.9.1
