From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2009 23:13:14 -0000
Subject: [RFC PATCH 08/10] PCMCIA: soc_common: remove 'dev' member from
	soc_pcmcia_socket
In-Reply-To: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <d9ad258f57eacd101f85fc9c8d8043096ccadf51.1256684685.git.rmk+kernel@arm.linux.org.uk>
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
index c9c104b..7f61b62 100644
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
