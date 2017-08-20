From: colin.king@canonical.com (Colin King)
Date: Sun, 20 Aug 2017 22:37:35 +0100
Subject: [PATCH] soc: ti: fix spelling mistake: "instace" -> "instance"
Message-ID: <20170820213735.14825-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/ti/knav_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 026182d3b27c..f463e04be412 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -431,7 +431,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 
 	chan_num = of_channel_match_helper(dev->of_node, name, &instance);
 	if (chan_num < 0) {
-		dev_err(kdev->dev, "No DMA instace with name %s\n", name);
+		dev_err(kdev->dev, "No DMA instance with name %s\n", name);
 		return (void *)-EINVAL;
 	}
 
@@ -454,7 +454,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 		}
 	}
 	if (!found) {
-		dev_err(kdev->dev, "No DMA instace with name %s\n", instance);
+		dev_err(kdev->dev, "No DMA instance with name %s\n", instance);
 		return (void *)-EINVAL;
 	}
 
-- 
2.11.0
