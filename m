From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Wed, 7 Feb 2018 18:35:35 +0100
Subject: [PATCH v1 2/3] media: stm32-dcmi: remove redundant clear of interrupt
 flags
In-Reply-To: <1518024936-2455-1-git-send-email-hugues.fruchet@st.com>
References: <1518024936-2455-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1518024936-2455-3-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is already cleared in dcmi_irq_callback().

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index abc79d8..dfab867 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -385,8 +385,6 @@ static irqreturn_t dcmi_irq_thread(int irq, void *arg)
 		dcmi->errors_count++;
 		dmaengine_terminate_all(dcmi->dma_chan);
 
-		reg_set(dcmi->regs, DCMI_ICR, IT_FRAME | IT_OVR | IT_ERR);
-
 		dev_dbg(dcmi->dev, "Restarting capture after DCMI error\n");
 
 		if (dcmi_start_capture(dcmi)) {
-- 
1.9.1
