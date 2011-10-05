From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  5 Oct 2011 17:04:56 +0100
Subject: [PATCH 05/16] dmaengine: pl330: Enable module alias autogeneration
	for AMBA drivers
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317830707-17517-6-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/dma/pl330.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 57104147..2d8d1b0 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -990,6 +990,8 @@ static struct amba_id pl330_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, pl330_ids);
+
 #ifdef CONFIG_PM_RUNTIME
 static int pl330_runtime_suspend(struct device *dev)
 {
-- 
1.7.4.1
