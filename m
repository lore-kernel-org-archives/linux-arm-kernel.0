From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 5 Jan 2012 11:11:13 +0800
Subject: [PATCH 1/2] arm/mxc: make imx_dma_is_general_purpose more generic for
 sdma
Message-ID: <1325733074-10749-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdma device names var when use device tree. So we just check
whether it includes "sdma" substring.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/include/mach/dma.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/dma.h b/arch/arm/plat-mxc/include/mach/dma.h
index 233d0a5..1b90803 100644
--- a/arch/arm/plat-mxc/include/mach/dma.h
+++ b/arch/arm/plat-mxc/include/mach/dma.h
@@ -60,8 +60,7 @@ static inline int imx_dma_is_ipu(struct dma_chan *chan)
 
 static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
 {
-	return !strcmp(dev_name(chan->device->dev), "imx31-sdma") ||
-		!strcmp(dev_name(chan->device->dev), "imx35-sdma") ||
+	return strstr(dev_name(chan->device->dev), "sdma") ||
 		!strcmp(dev_name(chan->device->dev), "imx-dma");
 }
 
-- 
1.7.5.4
