From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 26 Apr 2018 18:18:32 +0200
Subject: [PATCH 09/11] pinctrl: stm32: add irq_eoi for stm32gpio irqchip
In-Reply-To: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1524759514-12392-10-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

-Parent domain of stm32gpio evolves to hierarchy domain
 and could have a handle_fasteoi_irq. So an irq_eoi parent callback
 is needed for children.
-Replace space by tabulation.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 6cbcff4..dfed609 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -267,12 +267,13 @@ static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
 }
 
 static struct irq_chip stm32_gpio_irq_chip = {
-	.name           = "stm32gpio",
-	.irq_ack       = irq_chip_ack_parent,
-	.irq_mask       = irq_chip_mask_parent,
-	.irq_unmask     = irq_chip_unmask_parent,
-	.irq_set_type   = irq_chip_set_type_parent,
-	.irq_set_wake   = irq_chip_set_wake_parent,
+	.name		= "stm32gpio",
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_ack	= irq_chip_ack_parent,
+	.irq_mask	= irq_chip_mask_parent,
+	.irq_unmask	= irq_chip_unmask_parent,
+	.irq_set_type	= irq_chip_set_type_parent,
+	.irq_set_wake	= irq_chip_set_wake_parent,
 	.irq_request_resources = stm32_gpio_irq_request_resources,
 	.irq_release_resources = stm32_gpio_irq_release_resources,
 };
-- 
2.7.4
