From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 23 Aug 2011 03:29:44 +0530
Subject: [PATCH 2/3] ARM: SAMSUNG: Modify pl330 channel filter function
In-Reply-To: <1314050385-9617-2-git-send-email-thomas.abraham@linaro.org>
References: <1314050385-9617-1-git-send-email-thomas.abraham@linaro.org>
	<1314050385-9617-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1314050385-9617-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the change in dma channels private data information, the pl330
channel filter function is modified to look for a simple u8 value
instead of the now unused 'struct dma_pl330_peri' value.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/plat-samsung/dma-ops.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index 6e3d9ab..4f1430b 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -19,8 +19,8 @@
 
 static inline bool pl330_filter(struct dma_chan *chan, void *param)
 {
-	struct dma_pl330_peri *peri = chan->private;
-	return peri->peri_id == (unsigned)param;
+	u8 *peri_id = chan->private;
+	return *peri_id == (unsigned)param;
 }
 
 static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
-- 
1.6.6.rc2
