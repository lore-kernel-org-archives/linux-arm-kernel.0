From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 19:23:23 +0200
Subject: [PATCH 3/4] ARM: fix NOMMU __arm_ioremap prototype
In-Reply-To: <1367515404-512212-1-git-send-email-arnd@arndb.de>
References: <1367515404-512212-1-git-send-email-arnd@arndb.de>
Message-ID: <1367515404-512212-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The declaration of __arm_ioremap has changed to take a phys_addr_t
as the first argument, while the definition for nommu has not
changed. This adds the obvious change.

Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/nommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index e9f2e44..98303d9 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -88,7 +88,7 @@ void __iomem *__arm_ioremap_pfn_caller(unsigned long pfn, unsigned long offset,
 	return __arm_ioremap_pfn(pfn, offset, size, mtype);
 }
 
-void __iomem *__arm_ioremap(unsigned long phys_addr, size_t size,
+void __iomem *__arm_ioremap(phys_addr_t phys_addr, size_t size,
 			    unsigned int mtype)
 {
 	return (void __iomem *)phys_addr;
-- 
1.8.1.2
