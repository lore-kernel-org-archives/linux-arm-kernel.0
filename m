From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 30 Apr 2018 10:24:43 +0200
Subject: [PATCH 02/12] ARM: davinci: da830-evm: specify the chipselect in
 davinci_nand_pdata
In-Reply-To: <20180430082453.8091-1-brgl@bgdev.pl>
References: <20180430082453.8091-1-brgl@bgdev.pl>
Message-ID: <20180430082453.8091-3-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have the core_chipsel field in davinci_nand_pdata. Use it
instead of the platform_device id number.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index d283faefaf97..7cfb6f7e39e7 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -304,6 +304,7 @@ static struct davinci_aemif_timing da830_evm_nandflash_timing = {
 };
 
 static struct davinci_nand_pdata da830_evm_nand_pdata = {
+	.core_chipsel	= 1,
 	.parts		= da830_evm_nand_partitions,
 	.nr_parts	= ARRAY_SIZE(da830_evm_nand_partitions),
 	.ecc_mode	= NAND_ECC_HW,
-- 
2.17.0
