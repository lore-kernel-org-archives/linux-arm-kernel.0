From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 30 Apr 2018 10:24:48 +0200
Subject: [PATCH 07/12] ARM: davinci: dm644x-evm: specify the chipselect in
 davinci_nand_pdata
In-Reply-To: <20180430082453.8091-1-brgl@bgdev.pl>
References: <20180430082453.8091-1-brgl@bgdev.pl>
Message-ID: <20180430082453.8091-8-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have the core_chipsel field in davinci_nand_pdata. Use it
instead of the platform_device id number.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 190a28cc91bd..f76e22069e4b 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -152,6 +152,7 @@ static struct davinci_aemif_timing davinci_evm_nandflash_timing = {
 };
 
 static struct davinci_nand_pdata davinci_evm_nandflash_data = {
+	.core_chipsel	= 0,
 	.parts		= davinci_evm_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(davinci_evm_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
-- 
2.17.0
