From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Jul 2014 20:09:43 +0100
Subject: [PATCH v7 02/11] arm64: Remove duplicate (SWAPPER|IDMAP)_DIR_SIZE
 definitions
In-Reply-To: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
References: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1405537792-23666-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just keep the asm/page.h definition as this is included in vmlinux.lds.S
as well.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e0ccceb317d9..d7455fa83bc7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -383,9 +383,6 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 
-#define SWAPPER_DIR_SIZE	(3 * PAGE_SIZE)
-#define IDMAP_DIR_SIZE		(2 * PAGE_SIZE)
-
 /*
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
