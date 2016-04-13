From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 13 Apr 2016 12:30:52 +0200
Subject: [PATCH 2/6] base: Export platform_msi_create_irq_domain
In-Reply-To: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
References: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
Message-ID: <1460543456-11345-3-git-send-email-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Export platform_msi_create_irq_domain to make it useable from within
modules.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/base/platform-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 279e539..9ae0443 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -200,6 +200,7 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 
 	return domain;
 }
+EXPORT_SYMBOL_GPL(platform_msi_create_irq_domain);
 
 static struct platform_msi_priv_data *
 platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
-- 
2.6.6
