From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 9 Dec 2009 18:50:58 +0800
Subject: [PATCH 1/2] pcmcia: export pxa2xx_drv_pcmcia_{add_one, ops}
Message-ID: <mailman.91.1260709795.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

to other modules

Otherwise prevents pxa2xx_{lubbock, mainstone, ...} from being built as
modules, complaining about missing symbols.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 drivers/pcmcia/pxa2xx_base.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 84dde77..cc2ec79 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -252,6 +252,7 @@ int pxa2xx_drv_pcmcia_add_one(struct soc_pcmcia_socket *skt)

 	return soc_pcmcia_add_one(skt);
 }
+EXPORT_SYMBOL_GPL(pxa2xx_drv_pcmcia_add_one);

 void pxa2xx_drv_pcmcia_ops(struct pcmcia_low_level *ops)
 {
@@ -261,6 +262,7 @@ void pxa2xx_drv_pcmcia_ops(struct pcmcia_low_level *ops)
 	ops->frequency_change = pxa2xx_pcmcia_frequency_change;
 #endif
 }
+EXPORT_SYMBOL_GPL(pxa2xx_drv_pcmcia_ops);

 int __pxa2xx_drv_pcmcia_probe(struct device *dev)
 {
-- 
1.6.3.3
