From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 13 Apr 2016 12:30:53 +0200
Subject: [PATCH 3/6] genirq/msi: Export msi_get_domain_info
In-Reply-To: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
References: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
Message-ID: <1460543456-11345-4-git-send-email-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Allow modules to call msi_get_domain_info.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
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
2.6.6
