From: robherring2@gmail.com (Rob Herring)
Date: Fri, 21 Mar 2014 16:08:42 -0500
Subject: [PATCH 2/8] arm64: add FIXMAP_PAGE_NOCACHE definition
In-Reply-To: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
Message-ID: <1395436128-11244-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Similar to ioremap and ioremap_nocache, we want the same definition for
both using PROT_DEVICE_nGnRE.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fixmap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 5f7bfe6..68eab3c 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -54,7 +54,8 @@ enum fixed_addresses {
 #define FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
-#define FIXMAP_PAGE_IO     __pgprot(PROT_DEVICE_nGnRE)
+#define FIXMAP_PAGE_IO		__pgprot(PROT_DEVICE_nGnRE)
+#define FIXMAP_PAGE_NOCACHE	__pgprot(PROT_DEVICE_nGnRE)
 
 extern void __early_set_fixmap(enum fixed_addresses idx,
 			       phys_addr_t phys, pgprot_t flags);
-- 
1.8.3.2
