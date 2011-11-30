From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 29 Nov 2011 18:32:22 -0700
Subject: [PATCH 1/2] irq: Add dummy irq_domain_add_simple_when not defined
Message-ID: <1322616743-31985-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prevents users of this API from having to ifdef it.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/linux/irqdomain.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 99834e5..77b1751 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -99,6 +99,8 @@ extern void irq_domain_add_simple(struct device_node *controller, int irq_base);
 extern void irq_domain_generate_simple(const struct of_device_id *match,
 					u64 phys_base, unsigned int irq_start);
 #else /* CONFIG_IRQ_DOMAIN && CONFIG_OF_IRQ */
+static inline void irq_domain_add_simple(struct device_node *controller,
+					int irq_base) { }
 static inline void irq_domain_generate_simple(const struct of_device_id *match,
 					u64 phys_base, unsigned int irq_start) { }
 #endif /* CONFIG_IRQ_DOMAIN && CONFIG_OF_IRQ */
-- 
1.7.0.4
