From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 14 Sep 2010 16:14:15 +0800
Subject: ARM: dove: fix __io() definition to use bus based offset
Message-ID: <AANLkTim+u9qqTaGwzHKGfD+3nGammQDNWG6BoKkwfg2F@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 821049d2bab27613f5f18639cf231e1c2230e5a9
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Tue Sep 14 16:06:22 2010 +0800

    ARM: dove: fix __io() definition to use bus based offset

    Signed-off-by: Eric Miao <eric.miao@canonical.com>

This was proposed month ago, and had some other discussions about
typesafe_io() and type casting. I hereby simplified the patch to its
minimum and let's address the real issue first.

Saeed, Acked?


diff --git a/arch/arm/mach-dove/include/mach/io.h
b/arch/arm/mach-dove/include/mach/io.h
index 3b3e472..eb4936f 100644
--- a/arch/arm/mach-dove/include/mach/io.h
+++ b/arch/arm/mach-dove/include/mach/io.h
@@ -13,8 +13,8 @@

 #define IO_SPACE_LIMIT		0xffffffff

-#define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
-				   DOVE_PCIE0_IO_VIRT_BASE))
-#define __mem_pci(a)		(a)
+#define __io(a)  	((void __iomem *)(((a) - DOVE_PCIE0_IO_BUS_BASE) + \
+						 DOVE_PCIE0_IO_VIRT_BASE))
+#define __mem_pci(a)	(a)

 #endif
