From: b32955@freescale.com (Huang Shijie)
Date: Thu, 29 Aug 2013 16:29:25 +0800
Subject: [PATCH] serial: imx: initialize the local variable
Message-ID: <1377764965-2000-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The slave_config is not initialized, so some of its fields may
be set with random data which may causes the failure in the following
dmaengine_prep_slave_sg().

This patch fixes this issue.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 2c13155..a0ebbc9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -979,7 +979,7 @@ static void imx_uart_dma_exit(struct imx_port *sport)
 
 static int imx_uart_dma_init(struct imx_port *sport)
 {
-	struct dma_slave_config slave_config;
+	struct dma_slave_config slave_config = {};
 	struct device *dev = sport->port.dev;
 	int ret;
 
-- 
1.7.1
