From: r.sricharan@ti.com (Sricharan R)
Date: Tue, 3 Jun 2014 13:12:55 +0530
Subject: [PATCH 03/14] irqchip: crossbar: fix checkpatch warning
In-Reply-To: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
References: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1401781386-4982-4-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

remove un-necessary space in function pointer.

Fixes checkpatch warning:
WARNING: Unnecessary space before function pointer arguments
 #37: FILE: drivers/irqchip/irq-crossbar.c:37:
 +	void (*write) (int, int);

WARNING: Missing a blank line after declarations
+	int *register_offsets;
+	void (*write)(int, int);

WARNING: Prefer kcalloc over kzalloc with multiply
+	cb->irq_map = kzalloc(max * sizeof(int), GFP_KERNEL);

WARNING: Prefer kcalloc over kzalloc with multiply
+	cb->register_offsets = kzalloc(max * sizeof(int), GFP_KERNEL);

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 5da9d36..58790d4 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -34,7 +34,8 @@ struct crossbar_device {
 	uint *irq_map;
 	void __iomem *crossbar_base;
 	int *register_offsets;
-	void (*write) (int, int);
+
+	void (*write)(int, int);
 };
 
 /**
@@ -150,7 +151,7 @@ static int __init crossbar_of_init(struct device_node *node,
 		goto err1;
 
 	of_property_read_u32(node, "ti,max-irqs", &max);
-	cb->irq_map = kzalloc(max * sizeof(int), GFP_KERNEL);
+	cb->irq_map = kcalloc(max, sizeof(int), GFP_KERNEL);
 	if (!cb->irq_map)
 		goto err2;
 
@@ -176,7 +177,7 @@ static int __init crossbar_of_init(struct device_node *node,
 		}
 	}
 
-	cb->register_offsets = kzalloc(max * sizeof(int), GFP_KERNEL);
+	cb->register_offsets = kcalloc(max, sizeof(int), GFP_KERNEL);
 	if (!cb->register_offsets)
 		goto err3;
 
-- 
1.7.9.5
