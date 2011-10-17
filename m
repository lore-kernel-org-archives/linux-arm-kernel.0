From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Oct 2011 14:15:10 +0800
Subject: [PATCH 5/5] mmc: mxcmmc: explicitly includes mach/hardware.h
In-Reply-To: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
References: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1318832110-29289-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When indirect inclusion to <mach/hardware.h> via <mach/gpio.h> gets
removed, we will see the following compile error.

  CC      drivers/mmc/host/mxcmmc.o
drivers/mmc/host/mxcmmc.c: In function ?mxcmci_init_card?:
drivers/mmc/host/mxcmmc.c:811:2: error: implicit declaration of function ?cpu_is_mx3?

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxcmmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 14aa213..6632e38 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -40,6 +40,7 @@
 #include <mach/mmc.h>
 
 #include <mach/dma.h>
+#include <mach/hardware.h>
 
 #define DRIVER_NAME "mxc-mmc"
 
-- 
1.7.4.1
