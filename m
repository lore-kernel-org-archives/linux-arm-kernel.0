From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 Nov 2011 13:30:29 +0000
Subject: [PATCH 5/7] ARM: S3C64XX: Run Tobermory interrupts in the default mode
In-Reply-To: <1322573431-8923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111129133006.GA26800@opensource.wolfsonmicro.com>
 <1322573431-8923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1322573431-8923-5-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need not to now that generic emulation is provided for the PMIC IRQ
controller.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 003c171..6387ced 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -72,7 +72,6 @@ static struct wm8962_pdata wm8962_pdata __initdata = {
 		0x8000 | WM8962_GPIO_FN_DMICDAT,
 		WM8962_GPIO_FN_IRQ,    /* Open drain mode */
 	},
-	.irq_active_low = true,
 };
 
 static struct wm9081_pdata wm9081_pdata __initdata = {
-- 
1.7.7.3
