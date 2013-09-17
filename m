From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue, 17 Sep 2013 15:56:05 +0200
Subject: [[PATCH] 0/3] imx-dma: fixes
Message-ID: <1379426168-31989-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series is solving some lockdep issues in the imx-dma code.
There are some list_head and deadlock issues in the code,
that is running the implementation into unsafe situations.

Regards,
Michael

Michael Grzeschik (3):
  dma: imx-dma: fix slow path issue in prep_dma_cyclic
  dma: imx-dma: fix lockdep issue between irqhandler and tasklet
  dma: imx-dma: fix callback path in tasklet

 drivers/dma/imx-dma.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

-- 
1.8.4.rc3
