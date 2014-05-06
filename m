From: 21cnbao@gmail.com (Barry Song)
Date: Tue,  6 May 2014 22:58:36 +0800
Subject: [PATCH] irqchip: sirf: fix 'line over 80 characters'
Message-ID: <1399388316-19465-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bin Shi <Bin.Shi@csr.com>

fix "line line over 80 characters" for the below:
static int __init sirfsoc_irq_init(struct device_node *np, struct device_node *parent)

the users of the codes - key customers really care about that.

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/irqchip/irq-sirfsoc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
index 581eefe..5e54f6d 100644
--- a/drivers/irqchip/irq-sirfsoc.c
+++ b/drivers/irqchip/irq-sirfsoc.c
@@ -58,7 +58,8 @@ static void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
 	handle_IRQ(irqnr, regs);
 }
 
-static int __init sirfsoc_irq_init(struct device_node *np, struct device_node *parent)
+static int __init sirfsoc_irq_init(struct device_node *np,
+	struct device_node *parent)
 {
 	void __iomem *base = of_iomap(np, 0);
 	if (!base)
-- 
1.7.5.4
