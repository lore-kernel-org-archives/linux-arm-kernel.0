From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  6 Oct 2014 15:52:33 +0200
Subject: [PATCH 1/9] ARC: Remove redundant PCI_IOBASE declaration
In-Reply-To: <1412603561-27653-1-git-send-email-thierry.reding@gmail.com>
References: <1412603561-27653-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1412603561-27653-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

ARC's asm/io.h includes the asm-generic/io.h which already defines the
PCI_IOBASE variable in exactly the same way, so it can be dropped from
the architecture specific header.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arc/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index 334ce7017a18..cabd518cb253 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -13,8 +13,6 @@
 #include <asm/byteorder.h>
 #include <asm/page.h>
 
-#define PCI_IOBASE ((void __iomem *)0)
-
 extern void __iomem *ioremap(unsigned long physaddr, unsigned long size);
 extern void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 				  unsigned long flags);
-- 
2.1.0
