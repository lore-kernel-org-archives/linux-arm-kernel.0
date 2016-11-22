From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 09:26:03 +0000
Subject: [RFC PATCH 06/11] ARM: tlbflush: drop dependency on CONFIG_SMP
In-Reply-To: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1479806768-39911-7-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It can be referenced in UP case as well.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/tlbflush.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index def9e57..d9a6e2e 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -641,7 +641,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 
 #endif
 
-#elif defined(CONFIG_SMP)	/* !CONFIG_MMU */
+#else /* !CONFIG_MMU */
 
 #ifndef __ASSEMBLY__
 
-- 
1.7.9.5
