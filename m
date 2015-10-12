From: yalin.wang2010@gmail.com (yalin wang)
Date: Mon, 12 Oct 2015 10:28:18 +0800
Subject: [RFC] arm64: ioremap: add ioremap_cache macro
Message-ID: <1444616898-5057-1-git-send-email-yalin.wang2010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ioremap_cache macro, because some code will test if this macro
is defined or not, and will generate a generric version if not defined,
for example, memremap.c do like this.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm64/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 44be1e0..d6b620c 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -172,6 +172,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_wt(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define iounmap				__iounmap
+#define ioremap_cache                  ioremap_cache
 
 /*
  * io{read,write}{16,32}be() macros
-- 
1.9.1
