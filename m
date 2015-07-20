From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jul 2015 14:41:12 +0200
Subject: [PATCH 2/4] pinctrl: sunxi: Add irq_chip name
In-Reply-To: <1437396074-15791-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1437396074-15791-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1437396074-15791-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to ease the debugging, add a name to the irq_chips.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 777669d0a955..87c327993afa 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -685,6 +685,7 @@ static void sunxi_pinctrl_irq_ack_unmask(struct irq_data *d)
 }
 
 static struct irq_chip sunxi_pinctrl_edge_irq_chip = {
+	.name		= "sunxi_pio_edge",
 	.irq_ack	= sunxi_pinctrl_irq_ack,
 	.irq_mask	= sunxi_pinctrl_irq_mask,
 	.irq_unmask	= sunxi_pinctrl_irq_unmask,
@@ -695,6 +696,7 @@ static struct irq_chip sunxi_pinctrl_edge_irq_chip = {
 };
 
 static struct irq_chip sunxi_pinctrl_level_irq_chip = {
+	.name		= "sunxi_pio_level",
 	.irq_eoi	= sunxi_pinctrl_irq_ack,
 	.irq_mask	= sunxi_pinctrl_irq_mask,
 	.irq_unmask	= sunxi_pinctrl_irq_unmask,
-- 
2.4.5
