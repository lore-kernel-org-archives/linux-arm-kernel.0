From: kaloz@openwrt.org (Imre Kaloz)
Date: Tue,  2 Nov 2010 12:44:33 +0100
Subject: [PATCH] arm: export dma_set_coherent_mask
Message-ID: <1288698273-23595-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While a regression was fixed with commit 710224fa2750cf (arm: fix
"arm: fix pci_set_consistent_dma_mask for dmabounce devices"), a
new one was introduced as dma_set_coherent_mask wasn't exported
for modules. This patch takes care for this issue.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/arm/common/it8152.c          |    1 +
 arch/arm/mach-ixp4xx/common-pci.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index 1bec96e..42ff90b 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -352,3 +352,4 @@ struct pci_bus * __init it8152_pci_scan_bus(int nr, struct pci_sys_data *sys)
 	return pci_scan_bus(nr, &it8152_ops, sys);
 }
 
+EXPORT_SYMBOL(dma_set_coherent_mask);
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 24498a9..a54b3db 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -513,4 +513,4 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 
 EXPORT_SYMBOL(ixp4xx_pci_read);
 EXPORT_SYMBOL(ixp4xx_pci_write);
-
+EXPORT_SYMBOL(dma_set_coherent_mask);
-- 
1.7.1
