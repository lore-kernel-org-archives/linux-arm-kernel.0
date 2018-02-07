From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Wed, 7 Feb 2018 18:35:34 +0100
Subject: [PATCH v1 1/3] media: stm32-dcmi: remove redundant capture enable
In-Reply-To: <1518024936-2455-1-git-send-email-hugues.fruchet@st.com>
References: <1518024936-2455-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1518024936-2455-2-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove redundant capture enable already done
in dcmi_start_capture().

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 9460b30..abc79d8 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -255,9 +255,6 @@ static void dcmi_dma_callback(void *param)
 				spin_unlock(&dcmi->irqlock);
 				return;
 			}
-
-			/* Enable capture */
-			reg_set(dcmi->regs, DCMI_CR, CR_CAPTURE);
 		}
 
 		break;
-- 
1.9.1
