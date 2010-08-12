From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 12 Aug 2010 04:53:55 +0200
Subject: [PATCH 2/2] gen_nand: Test if nr_chips field is valid
In-Reply-To: <1281581635-26213-1-git-send-email-marek.vasut@gmail.com>
References: <1281581635-26213-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1281581635-26213-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/mtd/nand/plat_nand.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index 90e143e..317aff4 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -37,6 +37,11 @@ static int __devinit plat_nand_probe(struct platform_device *pdev)
 	struct resource *res;
 	int err = 0;
 
+	if (pdata->chip.nr_chips < 1) {
+		dev_err(&pdev->dev, "invalid number of chips specified\n");
+		return -EINVAL;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENXIO;
-- 
1.7.1
