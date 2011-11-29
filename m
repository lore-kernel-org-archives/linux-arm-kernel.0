From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 Nov 2011 13:30:26 +0000
Subject: [PATCH 2/7] ARM: S3C64XX: Use software initiated powerdown for
 Cragganmore
In-Reply-To: <1322573431-8923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111129133006.GA26800@opensource.wolfsonmicro.com>
 <1322573431-8923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1322573431-8923-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the two PMICs are independent we initiate a shutdown on each.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index b9a052a..3882c2f 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -501,6 +501,7 @@ static struct wm831x_pdata crag_pmic_pdata __initdata = {
 	.wm831x_num = 1,
 	.irq_base = BANFF_PMIC_IRQ_BASE,
 	.gpio_base = GPIO_BOARD_START + 8,
+	.soft_shutdown = true,
 
 	.backup = &banff_backup_pdata,
 
@@ -605,6 +606,7 @@ static struct wm831x_pdata glenfarclas_pmic_pdata __initdata = {
 	.wm831x_num = 2,
 	.irq_base = GLENFARCLAS_PMIC_IRQ_BASE,
 	.gpio_base = GLENFARCLAS_PMIC_GPIO_BASE,
+	.soft_shutdown = true,
 
 	.gpio_defaults = {
 		/* GPIO1-3: IRQ inputs, rising edge triggered, CMOS */
-- 
1.7.7.3
