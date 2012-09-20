From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:23 +0200
Subject: [PATCH 05/32] of/irq: Create stub for of_irq_find_parent when
 !CONFIG_OF
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_irq_find_parent is a handy function to use outside the confines of
the Open Firmware subsystem. One such use-case is when the IRQ Domain
wishes to find an IRQ domain for a given device node. Currently it can
not take any notice of the 'interrupt-parent' property. Instead it
just uses the first IRQ controller as it climbs the Device Tree. If
we were to use this as a precursor the resultant controller is more
likely to be correct.

Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/of_irq.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 1717cd9..b8e2411 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -83,6 +83,11 @@ static inline unsigned int irq_of_parse_and_map(struct device_node *dev,
 {
 	return 0;
 }
+
+static inline void *of_irq_find_parent(struct device_node *child)
+{
+	return NULL;
+}
 #endif /* !CONFIG_OF */
 
 #endif /* __OF_IRQ_H */
-- 
1.7.9.5
