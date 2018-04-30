From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 30 Apr 2018 10:24:49 +0200
Subject: [PATCH 08/12] ARM: davinci: mityomapl138: specify the chipselect in
 davinci_nand_pdata
In-Reply-To: <20180430082453.8091-1-brgl@bgdev.pl>
References: <20180430082453.8091-1-brgl@bgdev.pl>
Message-ID: <20180430082453.8091-9-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have the core_chipsel field in davinci_nand_pdata. Use it
instead of the platform_device id number.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index f442784eded3..2cce0d7d2f2a 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -400,6 +400,7 @@ static struct mtd_partition mityomapl138_nandflash_partition[] = {
 };
 
 static struct davinci_nand_pdata mityomapl138_nandflash_data = {
+	.core_chipsel	= 1,
 	.parts		= mityomapl138_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(mityomapl138_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
-- 
2.17.0
