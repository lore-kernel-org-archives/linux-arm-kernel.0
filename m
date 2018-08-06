From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 16:52:24 +0800
Subject: [PATCH v2 2/9] dmaengine: stm32-mdma: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-1-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
Message-ID: <20180806085231.4597-3-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.

Acked-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/stm32-mdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 06dd1725375e..390e4cae0e1a 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1656,7 +1656,7 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = dma_async_device_register(dd);
+	ret = dmaenginem_async_device_register(dd);
 	if (ret)
 		return ret;
 
@@ -1674,8 +1674,6 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	return 0;
 
 err_unregister:
-	dma_async_device_unregister(dd);
-
 	return ret;
 }
 
-- 
2.17.1
