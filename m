From: eric.auger@linaro.org (Eric Auger)
Date: Tue,  1 Mar 2016 18:27:49 +0000
Subject: [RFC v5 09/17] irqchip/gic-v3-its: ITS advertises
 MSI_FLAG_IRQ_REMAPPING
In-Reply-To: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
References: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1456856877-4817-10-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ITS is the first ARM MSI controller advertising the new
MSI_FLAG_IRQ_REMAPPING flag. It does so because it supports
interrupt translation service. This HW support offers isolation
of MSIs, feature used when using KVM device passthrough.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v5: new
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 3 ++-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index aee60ed..8223765 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -96,7 +96,8 @@ static struct msi_domain_ops its_pci_msi_ops = {
 
 static struct msi_domain_info its_pci_msi_domain_info = {
 	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX |
+		   MSI_FLAG_IRQ_REMAPPING),
 	.ops	= &its_pci_msi_ops,
 	.chip	= &its_msi_irq_chip,
 };
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 470b4aa..8c0d69d 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -63,7 +63,8 @@ static struct msi_domain_ops its_pmsi_ops = {
 };
 
 static struct msi_domain_info its_pmsi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_IRQ_REMAPPING),
 	.ops	= &its_pmsi_ops,
 	.chip	= &its_pmsi_irq_chip,
 };
-- 
1.9.1
