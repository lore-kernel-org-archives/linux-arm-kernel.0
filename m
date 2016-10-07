From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri,  7 Oct 2016 01:25:08 -0400
Subject: [PATCH V5 03/10] of: irq: make of_msi_configure accessible from
 modules
In-Reply-To: <1475817915-11976-1-git-send-email-okaya@codeaurora.org>
References: <1475817915-11976-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1475817915-11976-4-git-send-email-okaya@codeaurora.org>
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
index a2e68f7..20c09e0 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -767,3 +767,4 @@ void of_msi_configure(struct device *dev, struct device_node *np)
 	dev_set_msi_domain(dev,
 			   of_msi_get_domain(dev, np, DOMAIN_BUS_PLATFORM_MSI));
 }
+EXPORT_SYMBOL_GPL(of_msi_configure);
-- 
1.9.1
