From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Tue,  7 Aug 2018 00:29:07 +0200
Subject: [RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign mtd->dev.parent,
 not mtd->owner
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Message-ID: <20180806222918.12644-2-jmkrzyszt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix missing mtd->dev.parent assignment and drop useless mtd->owner.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 2a8872ebd14a..af313c620264 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -162,7 +162,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	}
 
 	ams_delta_mtd = nand_to_mtd(this);
-	ams_delta_mtd->owner = THIS_MODULE;
+	ams_delta_mtd->dev.parent = &pdev->dev;
 
 	/*
 	 * Don't try to request the memory region from here,
-- 
2.16.4
