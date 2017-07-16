From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 16 Jul 2017 10:30:38 -0400
Subject: [PATCH 2/2] dmaengine: qcom_hidma: correct channel QOS register offset
In-Reply-To: <1500215438-30672-1-git-send-email-okaya@codeaurora.org>
References: <1500215438-30672-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1500215438-30672-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A regression was found while testing QOS with different channels.
The QOS register offset is 0x700 rather than 0x300.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index d51cd34..c45e244 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -28,7 +28,7 @@
 
 #include "hidma_mgmt.h"
 
-#define HIDMA_QOS_N_OFFSET		0x300
+#define HIDMA_QOS_N_OFFSET		0x700
 #define HIDMA_CFG_OFFSET		0x400
 #define HIDMA_MAX_BUS_REQ_LEN_OFFSET	0x41C
 #define HIDMA_MAX_XACTIONS_OFFSET	0x420
-- 
1.9.1
