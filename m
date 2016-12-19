From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Mon, 19 Dec 2016 22:28:54 +0100
Subject: [PATCH 2/2] mfd: mc13xxx: Pass the IRQF_TRIGGER_HIGH flag.
In-Reply-To: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
References: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
Message-ID: <1482182934-18559-3-git-send-email-lilja.magnus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All supported mc13xxx devices have active high interrupt outputs. Make sure
to configure the interrupt as active high by passing the IRQF_TRIGGER_HIGH
flag. This is required at least on the i.MX31 PDK board.

Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>
---

 drivers/mfd/mc13xxx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index d7f54e4..4cbe6b7 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -440,7 +440,7 @@ int mc13xxx_common_init(struct device *dev)
 	mc13xxx->irq_chip.irqs = mc13xxx->irqs;
 	mc13xxx->irq_chip.num_irqs = ARRAY_SIZE(mc13xxx->irqs);
 
-	ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq, IRQF_ONESHOT,
+	ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq, IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
 				  0, &mc13xxx->irq_chip, &mc13xxx->irq_data);
 	if (ret)
 		return ret;
-- 
2.7.4
