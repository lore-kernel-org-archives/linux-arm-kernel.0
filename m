From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 16 Jan 2013 10:48:23 +0100
Subject: [PATCH 1/5] W1: Add device tree support to MXC onewire master.
In-Reply-To: <20130116094821.9660.18278.stgit@localhost>
References: <20130116094821.9660.18278.stgit@localhost>
Message-ID: <20130116094823.9660.2116.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/w1/masters/mxc_w1.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 708a25f..949e566 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -186,9 +186,16 @@ static int mxc_w1_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id mxc_w1_dt_ids[] = {
+	{ .compatible = "fsl,imx21-owire" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxc_w1_dt_ids);
+
 static struct platform_driver mxc_w1_driver = {
 	.driver = {
-		   .name = "mxc_w1",
+		.name = "mxc_w1",
+		.of_match_table = mxc_w1_dt_ids,
 	},
 	.probe = mxc_w1_probe,
 	.remove = mxc_w1_remove,
