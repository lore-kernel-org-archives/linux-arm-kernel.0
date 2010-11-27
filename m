From: ben@decadent.org.uk (Ben Hutchings)
Date: Sat, 27 Nov 2010 22:14:03 +0000
Subject: [PATCH] arm: Export dma_set_coherent_mask() implementations
Message-ID: <1290896043.3292.52.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 710224fa2750cf449c02dd115548acebfdd2c86a 'arm: fix "arm: fix
pci_set_consistent_dma_mask for dmabounce devices"' made
dma_set_coherent_mask() an extern function for some ARM platforms.
Since this function is called from many drivers, it must be exported.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: stable at kernel.org [2.6.36]
---
This is not even compile-tested yet, as I don't have a readily available
ARM build system.  Should be obvious though, right?

Ben.

 arch/arm/common/it8152.c          |    1 +
 arch/arm/mach-ixp4xx/common-pci.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index 60dc077..665708c 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -278,6 +278,7 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 
 	return -EIO;
 }
+EXPORT_SYMBOL(dma_set_coherent_mask);
 
 int __init it8152_pci_setup(int nr, struct pci_sys_data *sys)
 {
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 24498a9..c3d3d86 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -510,6 +510,7 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 
 	return -EIO;
 }
+EXPORT_SYMBOL(dma_set_coherent_mask);
 
 EXPORT_SYMBOL(ixp4xx_pci_read);
 EXPORT_SYMBOL(ixp4xx_pci_write);
-- 
1.7.2.3
