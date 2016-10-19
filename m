From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 19 Oct 2016 13:51:45 -0400
Subject: [PATCH V6 03/10] of: irq: make of_msi_configure accessible from
 modules
In-Reply-To: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
References: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1476899512-20431-4-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_msi_configure routine is only accessible by the built-in
kernel drivers. Export this function so that modules can use it
too.

This function is useful for configuring MSI on child device tree
nodes on hierarchical objects.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 393fea8..3fda9a3 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -697,3 +697,4 @@ void of_msi_configure(struct device *dev, struct device_node *np)
 	dev_set_msi_domain(dev,
 			   of_msi_get_domain(dev, np, DOMAIN_BUS_PLATFORM_MSI));
 }
+EXPORT_SYMBOL_GPL(of_msi_configure);
-- 
1.9.1
