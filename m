From: joel@joelfernandes.org (Joel Fernandes (Google))
Date: Mon,  8 Oct 2018 22:47:48 -0700
Subject: [PATCH 3/7] dmaengine: stm32-dma: fix typo and reported checkpatch
 warnings
In-Reply-To: <20181009054752.145978-1-joel@joelfernandes.org>
References: <20181009054752.145978-1-joel@joelfernandes.org>
Message-ID: <20181009054752.145978-4-joel@joelfernandes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>

Fix typo in a comment and solved reported checkpatch warnings.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/stm32-dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index fae7de54f00a..b64e14a83dec 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -60,7 +60,8 @@
 #define STM32_DMA_SCR_PINC		BIT(9) /* Peripheral increment mode */
 #define STM32_DMA_SCR_CIRC		BIT(8) /* Circular mode */
 #define STM32_DMA_SCR_PFCTRL		BIT(5) /* Peripheral Flow Controller */
-#define STM32_DMA_SCR_TCIE		BIT(4) /* Transfer Cplete Int Enable*/
+#define STM32_DMA_SCR_TCIE		BIT(4) /* Transfer Complete Int Enable
+						*/
 #define STM32_DMA_SCR_TEIE		BIT(2) /* Transfer Error Int Enable */
 #define STM32_DMA_SCR_DMEIE		BIT(1) /* Direct Mode Err Int Enable */
 #define STM32_DMA_SCR_EN		BIT(0) /* Stream Enable */
@@ -918,7 +919,7 @@ static enum dma_status stm32_dma_tx_status(struct dma_chan *c,
 	u32 residue = 0;
 
 	status = dma_cookie_status(c, cookie, state);
-	if ((status == DMA_COMPLETE) || (!state))
+	if (status == DMA_COMPLETE || !state)
 		return status;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
@@ -982,7 +983,7 @@ static void stm32_dma_desc_free(struct virt_dma_desc *vdesc)
 }
 
 static void stm32_dma_set_config(struct stm32_dma_chan *chan,
-			  struct stm32_dma_cfg *cfg)
+				 struct stm32_dma_cfg *cfg)
 {
 	stm32_dma_clear_reg(&chan->chan_reg);
 
@@ -1015,8 +1016,8 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
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
2.19.0.605.g01d371f741-goog
