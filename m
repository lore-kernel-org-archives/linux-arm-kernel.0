From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:21:17 +0200
Subject: [PATCH 01/13] irq: Add stub for none DT build in irqdomain.h
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314897689-17791-2-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an empty funtion to allow building a file without
adding some #ifdef CONFIG_OF around of APIs.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Grant Likely <grant.likely@secretlab.ca>
---
 include/linux/irqdomain.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e807ad6..6fa08ab 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -84,6 +84,8 @@ extern void irq_domain_add_simple(struct device_node *controller, int irq_base);
 extern void irq_domain_generate_simple(const struct of_device_id *match,
 					u64 phys_base, unsigned int irq_start);
 #else /* CONFIG_IRQ_DOMAIN && CONFIG_OF_IRQ */
+static inline void irq_domain_add_simple(struct device_node *controller,
+					 int irq_base) { }
 static inline void irq_domain_generate_simple(const struct of_device_id *match,
 					u64 phys_base, unsigned int irq_start) { }
 #endif /* CONFIG_IRQ_DOMAIN && CONFIG_OF_IRQ */
-- 
1.7.0.4
