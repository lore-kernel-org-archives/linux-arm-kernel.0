From: eric.auger@linaro.org (Eric Auger)
Date: Tue,  1 Mar 2016 18:27:50 +0000
Subject: [RFC v5 10/17] msi: export msi_get_domain_info
In-Reply-To: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
References: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1456856877-4817-11-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We plan to use msi_get_domain_info in VFIO module so let's export it.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v2 -> v3:
- remove static implementation in case CONFIG_PCI_MSI_IRQ_DOMAIN is not set
---
 kernel/irq/msi.c | 1 +
 1 file changed, 1 insertion(+)

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
