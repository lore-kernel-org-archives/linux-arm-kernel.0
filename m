From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 13 Mar 2018 17:42:07 +0100
Subject: [PATCH v1 8/8] dmaengine: stm32-dma: fix typo and reported checkpatch
 warnings
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1520959327-25760-9-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typo in a comment and solved reported checkpatch warnings.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 38c545d..8c58073 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -66,7 +66,8 @@
 #define STM32_DMA_SCR_PINC		BIT(9) /* Peripheral increment mode */
 #define STM32_DMA_SCR_CIRC		BIT(8) /* Circular mode */
 #define STM32_DMA_SCR_PFCTRL		BIT(5) /* Peripheral Flow Controller */
-#define STM32_DMA_SCR_TCIE		BIT(4) /* Transfer Cplete Int Enable*/
+#define STM32_DMA_SCR_TCIE		BIT(4) /* Transfer Complete Int Enable
+						*/
 #define STM32_DMA_SCR_TEIE		BIT(2) /* Transfer Error Int Enable */
 #define STM32_DMA_SCR_DMEIE		BIT(1) /* Direct Mode Err Int Enable */
 #define STM32_DMA_SCR_EN		BIT(0) /* Stream Enable */
@@ -1094,7 +1095,7 @@ static enum dma_status stm32_dma_tx_status(struct dma_chan *c,
 	u32 residue = 0;
 
 	status = dma_cookie_status(c, cookie, state);
-	if ((status == DMA_COMPLETE) || (!state))
+	if (status == DMA_COMPLETE || !state)
 		return status;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
@@ -1158,7 +1159,7 @@ static void stm32_dma_desc_free(struct virt_dma_desc *vdesc)
 }
 
 static void stm32_dma_set_config(struct stm32_dma_chan *chan,
-			  struct stm32_dma_cfg *cfg)
+				 struct stm32_dma_cfg *cfg)
 {
 	stm32_dma_clear_reg(&chan->chan_reg);
 
@@ -1190,8 +1191,8 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 	cfg.stream_config = dma_spec->args[2];
 	cfg.features = dma_spec->args[3];
 
-	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) ||
-	    (cfg.request_line >= STM32_DMA_MAX_REQUEST_ID)) {
+	if (cfg.channel_id >= STM32_DMA_MAX_CHANNELS ||
+	    cfg.request_line >= STM32_DMA_MAX_REQUEST_ID) {
 		dev_err(dev, "Bad channel and/or request id\n");
 		return NULL;
 	}
-- 
2.7.4
