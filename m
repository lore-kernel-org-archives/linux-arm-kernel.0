From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 11 Feb 2016 14:34:19 +0000
Subject: [RFC v2 12/15] msi: export msi_get_domain_info
In-Reply-To: <1455201262-5259-1-git-send-email-eric.auger@linaro.org>
References: <1455201262-5259-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1455201262-5259-13-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We plan to use msi_get_domain_info in VFIO module so let's export it.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 include/linux/msi.h | 4 ++++
 kernel/irq/msi.c    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 03eda72..df19315 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -323,6 +323,10 @@ static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
 	return NULL;
 }
+static struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain)
+{
+	return NULL;
+}
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
 
 #endif /* LINUX_MSI_H */
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 38e89ce..9b0ba4a 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -400,5 +400,6 @@ struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain)
 {
 	return (struct msi_domain_info *)domain->host_data;
 }
+EXPORT_SYMBOL_GPL(msi_get_domain_info);
 
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
-- 
1.9.1
