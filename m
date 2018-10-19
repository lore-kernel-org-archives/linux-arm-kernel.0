From: hch@lst.de (Christoph Hellwig)
Date: Fri, 19 Oct 2018 14:09:46 +0200
Subject: [PATCH 3/9] powerpc: remove CONFIG_PCI_QSPAN
In-Reply-To: <20181019120952.32763-1-hch@lst.de>
References: <20181019120952.32763-1-hch@lst.de>
Message-ID: <20181019120952.32763-4-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This option isn't actually used anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a80669209155..e8c8970248bc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -955,7 +955,6 @@ config PCI
 	bool "PCI support" if PPC_PCI_CHOICE
 	default y if !40x && !CPM2 && !PPC_8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
-	default PCI_QSPAN if PPC_8xx
 	select GENERIC_PCI_IOMAP
 	help
 	  Find out whether your system includes a PCI bus. PCI is the name of
@@ -969,14 +968,6 @@ config PCI_DOMAINS
 config PCI_SYSCALL
 	def_bool PCI
 
-config PCI_QSPAN
-	bool "QSpan PCI"
-	depends on PPC_8xx
-	select PPC_I8259
-	help
-	  Say Y here if you have a system based on a Motorola 8xx-series
-	  embedded processor with a QSPAN PCI interface, otherwise say N.
-
 config PCI_8260
 	bool
 	depends on PCI && 8260
-- 
2.19.1
