From: tklauser@distanz.ch (Tobias Klauser)
Date: Fri, 20 Jun 2014 09:29:47 +0200
Subject: [PATCH] ARM: nommu: Remove unnecessary prototype for kobjsize()
Message-ID: <1403249387-27797-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prototype for kobjsize() is already defined in linux/mm.h which is
included where kobjsize() is used.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arm/include/asm/pgtable-nommu.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index 0642228..e184eaf 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -69,12 +69,6 @@ static inline int pte_file(pte_t pte) { return 0; }
 #define pgprot_writecombine(prot) __pgprot(0)
 #define pgprot_dmacoherent(prot) __pgprot(0)
 
-
-/*
- * These would be in other places but having them here reduces the diffs.
- */
-extern unsigned int kobjsize(const void *objp);
-
 /*
  * No page table caches to initialise.
  */
-- 
1.7.9.5
