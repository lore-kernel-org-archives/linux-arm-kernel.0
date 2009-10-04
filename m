From: rmk@arm.linux.org.uk (Russell King)
Date: Sun, 04 Oct 2009 16:09:08 +0100
Subject: [RFC PATCH 08/10] PCMCIA: soc_common: remove 'dev' member from
	soc_pcmcia_socket
In-Reply-To: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
References: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <670280073cf27f82bcee06b617cc1ee3cd29d069.1253722954.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'dev' member is now only ever written, so we can safely remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_base.c |    1 -
 drivers/pcmcia/sa11xx_base.c |    1 -
 drivers/pcmcia/soc_common.h  |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 4421dd0..c4bdbe9 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -288,7 +288,6 @@ int __pxa2xx_drv_pcmcia_probe(struct device *dev)
 
 		skt->nr = ops->first + i;
 		skt->irq = NO_IRQ;
-		skt->dev = dev;
 		skt->ops = ops;
 		skt->socket.owner = ops->owner;
 		skt->socket.dev.parent = dev;
diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index 4db8149..ac99872 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -236,7 +236,6 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 
 		skt->nr = first + i;
 		skt->irq = NO_IRQ;
-		skt->dev = dev;
 		skt->ops = ops;
 		skt->socket.owner = ops->owner;
 		skt->socket.dev.parent = dev;
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index f7533dc..4fb06f7 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -30,7 +30,6 @@ struct soc_pcmcia_socket {
 	/*
 	 * Info from low level handler
 	 */
-	struct device		*dev;
 	unsigned int		nr;
 	unsigned int		irq;
 
-- 
1.6.2.5
