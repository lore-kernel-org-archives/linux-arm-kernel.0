From: david@lechnology.com (David Lechner)
Date: Wed,  9 Mar 2016 17:50:02 -0600
Subject: [PATCH 1/4] mmc: davinci: remove matching string
In-Reply-To: <1457567405-30475-1-git-send-email-david@lechnology.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
Message-ID: <1457567405-30475-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The string "MMCSDCLK" is not actually used for clock lookup, so can be removed.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index ea2a2eb..469aa8c 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1280,7 +1280,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		goto out;
 
 	ret = -ENXIO;
-	host->clk = clk_get(&pdev->dev, "MMCSDCLK");
+	host->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
 		goto out;
-- 
1.9.1
