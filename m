From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 10:12:43 +0200
Subject: [PATCH 2/8] mtd: nand: add support for the TC58NVG2S0H chip
In-Reply-To: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
Message-ID: <62d5d978da8c6bc6b47c340c86e9a5fe5f6971ef.1476951078.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

Add the description of the Toshiba TC58NVG2S0H SLC nand to the nand_ids
table so we can use the NAND ECC infos and the ONFI timings.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mtd/nand/nand_ids.c | 3 +++
 1 file changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/nand_ids.c b/drivers/mtd/nand/nand_ids.c
index 2af9869a115e..b3a332f37e14 100644
--- a/drivers/mtd/nand/nand_ids.c
+++ b/drivers/mtd/nand/nand_ids.c
@@ -36,6 +36,9 @@ struct nand_flash_dev nand_flash_ids[] = {
 	{"TC58NVG2S0F 4G 3.3V 8-bit",
 		{ .id = {0x98, 0xdc, 0x90, 0x26, 0x76, 0x15, 0x01, 0x08} },
 		  SZ_4K, SZ_512, SZ_256K, 0, 8, 224, NAND_ECC_INFO(4, SZ_512) },
+	{"TC58NVG2S0H 4G 3.3V 8-bit",
+		{ .id = {0x98, 0xdc, 0x90, 0x26, 0x76, 0x16, 0x08, 0x00} },
+		  SZ_4K, SZ_512, SZ_256K, 0, 8, 256, NAND_ECC_INFO(8, SZ_512) },
 	{"TC58NVG3S0F 8G 3.3V 8-bit",
 		{ .id = {0x98, 0xd3, 0x90, 0x26, 0x76, 0x15, 0x02, 0x08} },
 		  SZ_4K, SZ_1K, SZ_256K, 0, 8, 232, NAND_ECC_INFO(4, SZ_512) },
-- 
git-series 0.8.10
