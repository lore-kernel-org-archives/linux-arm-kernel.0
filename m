From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 13 Jan 2012 11:10:00 +0800
Subject: [PATCH v2 5/6] dma/imx-sdma: use num_events to validate event_id0
In-Reply-To: <1326424201-20056-1-git-send-email-richard.zhao@linaro.org>
References: <1326424201-20056-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1326424201-20056-6-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

event number is not always 32. use num_events for checking instead.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/imx-sdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 015d93f..22fd561 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -723,7 +723,7 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
 	sdmac->per_addr = 0;
 
 	if (sdmac->event_id0) {
-		if (sdmac->event_id0 > 32)
+		if (sdmac->event_id0 >= sdmac->sdma->num_events)
 			return -EINVAL;
 		sdma_event_enable(sdmac, sdmac->event_id0);
 	}
-- 
1.7.5.4
