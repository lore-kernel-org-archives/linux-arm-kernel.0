From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:01:06 +0100
Subject: [PATCH 15/16] irqchip: vic: mark vic_of_init() as static
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-16-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all vic_of_init() users converted to the irqchip infrastructure,
there is no longer a reason for this function to be
exported. Therefore, mark it as static.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-vic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 98a0708..c8c8cab 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -440,7 +440,8 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 }
 
 #ifdef CONFIG_OF
-int __init vic_of_init(struct device_node *node, struct device_node *parent)
+static int __init vic_of_init(struct device_node *node,
+			      struct device_node *parent)
 {
 	void __iomem *regs;
 	int irq_base;
-- 
1.7.9.5
