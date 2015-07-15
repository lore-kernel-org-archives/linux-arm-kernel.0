From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:04:35 +0100
Subject: [PATCH 8/8] pcmcia: soc_common: remove skt_dev_info's clk pointer
In-Reply-To: <20150715180342.GB7557@n2100.arm.linux.org.uk>
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFR2p-0007Ms-4w@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We no longer need to store the clk pointer in struct skt_dev_info as we
no longer need to remember the clk pointer for the cleanup paths.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_base.c | 1 -
 drivers/pcmcia/sa11xx_base.c | 1 -
 drivers/pcmcia/soc_common.h  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 0f42d55e7c7f..483f919e0d2e 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -308,7 +308,6 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 		return -ENOMEM;
 
 	sinfo->nskt = ops->nr;
-	sinfo->clk = clk;
 
 	/* Initialize processor specific parameters */
 	for (i = 0; i < ops->nr; i++) {
diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index 815b6950975c..9f6ec87b9f9e 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -233,7 +233,6 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 		return -ENOMEM;
 
 	sinfo->nskt = nr;
-	sinfo->clk = clk;
 
 	/* Initialize processor specific parameters */
 	for (i = 0; i < nr; i++) {
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index e6fcbea5b682..94762a54d731 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -68,7 +68,6 @@ struct soc_pcmcia_socket {
 
 struct skt_dev_info {
 	int nskt;
-	struct clk *clk;
 	struct soc_pcmcia_socket skt[0];
 };
 
-- 
2.1.0
