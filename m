From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 17 Jun 2013 10:29:12 -0700
Subject: [PATCHv2 1/3] arm: Add definitions for pte_mkexec/pte_mknexec
In-Reply-To: <1371490154-11041-1-git-send-email-lauraa@codeaurora.org>
References: <1371490154-11041-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1371490154-11041-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Other architectures define pte_mkexec to mark a pte as executable.
Add pte_mkexec for ARM to get the same functionality. Although no
other architectures currently define it, also add pte_mknexec to
explicitly allow a pte to be marked as non executable.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/include/asm/pgtable.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 9bcd262..135381b 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -251,6 +251,8 @@ PTE_BIT_FUNC(mkclean,   &= ~L_PTE_DIRTY);
 PTE_BIT_FUNC(mkdirty,   |= L_PTE_DIRTY);
 PTE_BIT_FUNC(mkold,     &= ~L_PTE_YOUNG);
 PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
+PTE_BIT_FUNC(mkexec,   &= ~L_PTE_XN);
+PTE_BIT_FUNC(mknexec,   |= L_PTE_XN);
 
 static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
