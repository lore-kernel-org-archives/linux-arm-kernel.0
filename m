From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Dec 2013 15:35:19 -0800
Subject: [PATCH 4/8] mfd: ssbi: Mark match table const
In-Reply-To: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1386718523-2587-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a read-only data structure.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mfd/ssbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ssbi.c b/drivers/mfd/ssbi.c
index dd1d28f..b78942e 100644
--- a/drivers/mfd/ssbi.c
+++ b/drivers/mfd/ssbi.c
@@ -317,7 +317,7 @@ static int ssbi_probe(struct platform_device *pdev)
 	return of_platform_populate(np, NULL, NULL, &pdev->dev);
 }
 
-static struct of_device_id ssbi_match_table[] = {
+static const struct of_device_id ssbi_match_table[] = {
 	{ .compatible = "qcom,ssbi" },
 	{}
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
