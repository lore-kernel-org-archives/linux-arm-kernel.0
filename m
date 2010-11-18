From: brian@walsh.ws (Brian Walsh)
Date: Wed, 17 Nov 2010 23:25:10 -0500
Subject: [PATCH] arm: ixp4xx export symbol dma_set_coherent_mask
Message-ID: <201011172325.10894.brian@walsh.ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM ixp4xx module building has been broken since commit 710224fa2750.
arm: fix "arm: fix pci_set_consistent_dma_mask for dmabounce devices"

Signed-off-by: Brian Walsh <brian@walsh.ws>

diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 24498a9..d54b219 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -513,4 +513,5 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 
 EXPORT_SYMBOL(ixp4xx_pci_read);
 EXPORT_SYMBOL(ixp4xx_pci_write);
+EXPORT_SYMBOL(dma_set_coherent_mask);
