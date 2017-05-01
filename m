From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 1 May 2017 21:30:20 +0200
Subject: [PATCH 3/3] soc-knav_dma: Delete error messages for a failed memory
 allocation in two functions
In-Reply-To: <eddc35f7-a04b-42f5-ad8b-d345ca0b57b4@users.sourceforge.net>
References: <eddc35f7-a04b-42f5-ad8b-d345ca0b57b4@users.sourceforge.net>
Message-ID: <b37a7b6a-cee6-2536-1ffe-994a208d8d00@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 May 2017 21:14:48 +0200

The script "checkpatch.pl" pointed information out like the following.

WARNING: Possible unnecessary 'out of memory' message

Thus remove such statements here.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/soc/ti/knav_dma.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 410018d9054e..dd5adfbf9910 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -621,10 +621,9 @@ static int dma_init(struct device_node *cloud, struct device_node *dma_node)
 	u32 i;
 
 	dma = devm_kzalloc(kdev->dev, sizeof(*dma), GFP_KERNEL);
-	if (!dma) {
-		dev_err(kdev->dev, "could not allocate driver mem\n");
+	if (!dma)
 		return -ENOMEM;
-	}
+
 	INIT_LIST_HEAD(&dma->list);
 	INIT_LIST_HEAD(&dma->chan_list);
 
@@ -740,10 +739,8 @@ static int knav_dma_probe(struct platform_device *pdev)
 	}
 
 	kdev = devm_kzalloc(dev, sizeof(*kdev), GFP_KERNEL);
-	if (!kdev) {
-		dev_err(dev, "could not allocate driver mem\n");
+	if (!kdev)
 		return -ENOMEM;
-	}
 
 	kdev->dev = dev;
 	INIT_LIST_HEAD(&kdev->list);
-- 
2.12.2
