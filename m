From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 28 Sep 2018 10:36:34 +0200
Subject: [PATCH v2 7/7] dmaengine: stm32-mdma: enable descriptor_reuse
In-Reply-To: <1538123794-17085-1-git-send-email-pierre-yves.mordret@st.com>
References: <1538123794-17085-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1538123794-17085-8-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable reuse to spare descriptors creation on critical UC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-mdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 6b6e63b..80a17dd 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1715,6 +1715,8 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	dd->device_resume = stm32_mdma_resume;
 	dd->device_terminate_all = stm32_mdma_terminate_all;
 	dd->device_synchronize = stm32_mdma_synchronize;
+	dd->descriptor_reuse = true;
+
 	dd->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 		BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-- 
2.7.4
