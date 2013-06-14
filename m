From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 14 Jun 2013 18:40:46 +0200
Subject: [PATCH 4/7] mfd: stmpe: use irq_get_trigger_type() to get IRQ flags
In-Reply-To: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1371228049-27080-5-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irq_get_trigger_type() to get the IRQ trigger type flags
instead calling irqd_get_trigger_type(irq_get_irq_data(irq))

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/mfd/stmpe.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index bbccd51..5d5e6f9 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1208,8 +1208,7 @@ int stmpe_probe(struct stmpe_client_info *ci, int partnum)
 		}
 		stmpe->variant = stmpe_noirq_variant_info[stmpe->partnum];
 	} else if (pdata->irq_trigger == IRQF_TRIGGER_NONE) {
-		pdata->irq_trigger =
-			irqd_get_trigger_type(irq_get_irq_data(stmpe->irq));
+		pdata->irq_trigger = irq_get_trigger_type(stmpe->irq);
 	}
 
 	ret = stmpe_chip_init(stmpe);
-- 
1.7.7.6
