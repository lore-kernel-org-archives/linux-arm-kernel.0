From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  6 Apr 2011 16:31:02 +0200
Subject: [PATCH] pcmcia/sa1100: put sa11x0_pcmcia_hw_init[] to .devinit.data
Message-ID: <1302100262-18296-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sa11x0_pcmcia_hw_init is only used by sa11x0_drv_pcmcia_probe which
lives in .devinit.text so it can go to .devinit.data.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/pcmcia/sa1100_generic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index fb9740d..2eea664 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -43,7 +43,7 @@
 
 int __init pcmcia_collie_init(struct device *dev);
 
-static int (*sa11x0_pcmcia_hw_init[])(struct device *dev) = {
+static int (*sa11x0_pcmcia_hw_init[])(struct device *dev) __devinitdata = {
 #ifdef CONFIG_SA1100_ASSABET
 	pcmcia_assabet_init,
 #endif
-- 
1.7.2.3
