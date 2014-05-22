From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 22 May 2014 14:00:13 -0700
Subject: [PATCH 5/5] net: ks8851: Add of match table
In-Reply-To: <1400792413-21618-1-git-send-email-sboyd@codeaurora.org>
References: <1400792413-21618-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1400792413-21618-6-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Users are currently just providing "ks8851" as the compatible for
this driver in device tree. Add a compatible string that provides
the vendor name along with the driver name to be more explicit.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/net/ethernet/micrel/ks8851.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/micrel/ks8851.c b/drivers/net/ethernet/micrel/ks8851.c
index 3a322daba5ff..e72918970a58 100644
--- a/drivers/net/ethernet/micrel/ks8851.c
+++ b/drivers/net/ethernet/micrel/ks8851.c
@@ -1603,9 +1603,15 @@ static int ks8851_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id ks8851_match_table[] = {
+	{ .compatible = "micrel,ks8851" },
+	{ }
+};
+
 static struct spi_driver ks8851_driver = {
 	.driver = {
 		.name = "ks8851",
+		.of_match_table = ks8851_match_table,
 		.owner = THIS_MODULE,
 		.pm = &ks8851_pm_ops,
 	},
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
