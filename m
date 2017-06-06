From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Jun 2017 13:59:26 +0800
Subject: [PATCH 04/10] irqchip: sunxi-nmi: const-ify sunxi_sc_nmi_reg_offs
 structures
In-Reply-To: <20170606055932.22548-1-wens@csie.org>
References: <20170606055932.22548-1-wens@csie.org>
Message-ID: <20170606055932.22548-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi_sc_nmi_reg_offs, which hold the register offsets for the
various variants, is never modified, and only used at init time within
the init functions referenced by IRQCHIP_DECLARE, which themselves are
tagged __init.

Const-ify the sunxi_sc_nmi_reg_offs structures, and tag them as
__initconst.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/irqchip/irq-sunxi-nmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 76f2431b6b7b..e713ec66322b 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -52,19 +52,19 @@ struct sunxi_sc_nmi_reg_offs {
 	u32 enable;
 };
 
-static struct sunxi_sc_nmi_reg_offs sun6i_reg_offs = {
+static const struct sunxi_sc_nmi_reg_offs sun6i_reg_offs __initconst = {
 	.ctrl	= SUN6I_NMI_CTRL,
 	.pend	= SUN6I_NMI_PENDING,
 	.enable	= SUN6I_NMI_ENABLE,
 };
 
-static struct sunxi_sc_nmi_reg_offs sun7i_reg_offs = {
+static const struct sunxi_sc_nmi_reg_offs sun7i_reg_offs __initconst = {
 	.ctrl	= SUN7I_NMI_CTRL,
 	.pend	= SUN7I_NMI_PENDING,
 	.enable	= SUN7I_NMI_ENABLE,
 };
 
-static struct sunxi_sc_nmi_reg_offs sun9i_reg_offs = {
+static const struct sunxi_sc_nmi_reg_offs sun9i_reg_offs __initconst = {
 	.ctrl	= SUN9I_NMI_CTRL,
 	.pend	= SUN9I_NMI_PENDING,
 	.enable	= SUN9I_NMI_ENABLE,
@@ -142,7 +142,7 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 }
 
 static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
-					struct sunxi_sc_nmi_reg_offs *reg_offs)
+					const struct sunxi_sc_nmi_reg_offs *reg_offs)
 {
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
-- 
2.11.0
