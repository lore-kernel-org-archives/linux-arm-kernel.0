From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 27 Jun 2013 09:22:11 +0200
Subject: [PATCH 3/3] ARM: imx: flexcan: Remove platform file
In-Reply-To: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
References: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1372317731-24966-4-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

As there are no more users of the flexcan platform file, let's remove it.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/platform/flexcan.h | 20 --------------------
 1 file changed, 20 deletions(-)
 delete mode 100644 include/linux/can/platform/flexcan.h

diff --git a/include/linux/can/platform/flexcan.h b/include/linux/can/platform/flexcan.h
deleted file mode 100644
index 72b713a..0000000
--- a/include/linux/can/platform/flexcan.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (C) 2010 Marc Kleine-Budde <kernel@pengutronix.de>
- *
- * This file is released under the GPLv2
- *
- */
-
-#ifndef __CAN_PLATFORM_FLEXCAN_H
-#define __CAN_PLATFORM_FLEXCAN_H
-
-/**
- * struct flexcan_platform_data - flex CAN controller platform data
- * @transceiver_enable:         - called to power on/off the transceiver
- *
- */
-struct flexcan_platform_data {
-	void (*transceiver_switch)(int enable);
-};
-
-#endif /* __CAN_PLATFORM_FLEXCAN_H */
-- 
1.8.3.1
