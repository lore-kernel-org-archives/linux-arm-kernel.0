From: dirk.behme@googlemail.com (Dirk Behme)
Date: Sat, 28 Jul 2012 11:05:10 +0200
Subject: [PATCH] mtd: mxc_nand: Fix compiler warnings
Message-ID: <1343466310-14584-1-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dirk Behme <dirk.behme@googlemail.com>

Fix the compiler warnings

drivers/mtd/nand/mxc_nand.c:1267: warning: initialization discards qualifiers from pointer target type
drivers/mtd/nand/mxc_nand.c:1270: warning: initialization discards qualifiers from pointer target type
drivers/mtd/nand/mxc_nand.c:1273: warning: initialization discards qualifiers from pointer target type
drivers/mtd/nand/mxc_nand.c:1276: warning: initialization discards qualifiers from pointer target type

Signed-off-by: Dirk Behme <dirk.behme@googlemail.com>
---
 drivers/mtd/nand/mxc_nand.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 6acc790..31b125a 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1264,16 +1264,16 @@ static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 static const struct of_device_id mxcnd_dt_ids[] = {
 	{
 		.compatible = "fsl,imx21-nand",
-		.data = &imx21_nand_devtype_data,
+		.data = (void *)&imx21_nand_devtype_data,
 	}, {
 		.compatible = "fsl,imx27-nand",
-		.data = &imx27_nand_devtype_data,
+		.data = (void *)&imx27_nand_devtype_data,
 	}, {
 		.compatible = "fsl,imx25-nand",
-		.data = &imx25_nand_devtype_data,
+		.data = (void *)&imx25_nand_devtype_data,
 	}, {
 		.compatible = "fsl,imx51-nand",
-		.data = &imx51_nand_devtype_data,
+		.data = (void *)&imx51_nand_devtype_data,
 	},
 	{ /* sentinel */ }
 };
-- 
1.7.7.4
