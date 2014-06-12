From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Jun 2014 15:20:42 +0200
Subject: [PATCHv4 2/5] mtd: gpmi: remove line breaks from error messages and
 improve wording
In-Reply-To: <1402579245-13377-2-git-send-email-LW@KARO-electronics.de>
References: <1402579245-13377-1-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <1402579245-13377-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 31032b1..16a533a 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -285,9 +285,8 @@ static int legacy_set_geometry(struct gpmi_nand_data *this)
 	geo->ecc_strength = get_ecc_strength(this);
 	if (!gpmi_check_ecc(this)) {
 		dev_err(this->dev,
-			"We can not support this nand chip."
-			" Its required ecc strength(%d) is beyond our"
-			" capability(%d).\n", geo->ecc_strength,
+			"required ecc strength of the NAND chip: %d is not supported by the GPMI controller (%d)\n",
+			geo->ecc_strength,
 			this->devdata->bch_max_ecc_strength);
 		return -EINVAL;
 	}
@@ -1597,8 +1596,9 @@ static int mx23_boot_init(struct gpmi_nand_data  *this)
 			dev_dbg(dev, "Transcribing mark in block %u\n", block);
 			ret = chip->block_markbad(mtd, byte);
 			if (ret)
-				dev_err(dev, "Failed to mark block bad with "
-							"ret %d\n", ret);
+				dev_err(dev,
+					"Failed to mark block bad with ret %d\n",
+					ret);
 		}
 	}
 
-- 
1.7.10.4
