From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 26 Jun 2018 11:25:25 +0200
Subject: [PATCH v2 01/13] clk: davinci: psc-da850: remove the 'davinci_nand.0"
 lookup
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Message-ID: <20180626092537.6737-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit a8e3923ab571 ("mtd: rawnand: davinci: don't acquire and
enable clock") we no longer acquire the aemif clock from the davinci
nand driver - we only do it from the ti-aemif driver. Remove the nand
entry from the psc lookup table.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc-da850.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
index d196dcbed560..5a18bca464cd 100644
--- a/drivers/clk/davinci/psc-da850.c
+++ b/drivers/clk/davinci/psc-da850.c
@@ -16,8 +16,7 @@
 
 #include "psc.h"
 
-LPSC_CLKDEV2(emifa_clkdev,	NULL,		"ti-aemif",
-				"aemif",	"davinci_nand.0");
+LPSC_CLKDEV1(emifa_clkdev,	NULL,		"ti-aemif");
 LPSC_CLKDEV1(spi0_clkdev,	NULL,		"spi_davinci.0");
 LPSC_CLKDEV1(mmcsd0_clkdev,	NULL,		"da830-mmc.0");
 LPSC_CLKDEV1(uart0_clkdev,	NULL,		"serial8250.0");
-- 
2.17.1
