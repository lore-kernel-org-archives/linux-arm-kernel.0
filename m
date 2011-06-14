From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 14 Jun 2011 09:21:05 +0400
Subject: [PATCH] scoop: drop pcmcia_init callback
Message-ID: <1308028865-8460-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A pcmcia_init callback isn't used on any of the platforms. Drop it.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/include/asm/hardware/scoop.h |    1 -
 drivers/pcmcia/pxa2xx_sharpsl.c       |    3 ---
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/hardware/scoop.h b/arch/arm/include/asm/hardware/scoop.h
index ebb3cea..58cdf5d 100644
--- a/arch/arm/include/asm/hardware/scoop.h
+++ b/arch/arm/include/asm/hardware/scoop.h
@@ -61,7 +61,6 @@ struct scoop_pcmcia_dev {
 struct scoop_pcmcia_config {
 	struct scoop_pcmcia_dev *devs;
 	int num_devs;
-	void (*pcmcia_init)(void);
 	void (*power_ctrl)(struct device *scoop, unsigned short cpr, int nr);
 };
 
diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
index cece435..ca8cb322 100644
--- a/drivers/pcmcia/pxa2xx_sharpsl.c
+++ b/drivers/pcmcia/pxa2xx_sharpsl.c
@@ -48,9 +48,6 @@ static int sharpsl_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret;
 
-	if (platform_scoop_config->pcmcia_init)
-		platform_scoop_config->pcmcia_init();
-
 	/* Register interrupts */
 	if (SCOOP_DEV[skt->nr].cd_irq >= 0) {
 		struct pcmcia_irqs cd_irq;
-- 
1.7.5.3
