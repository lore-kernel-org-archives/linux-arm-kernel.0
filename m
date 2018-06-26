From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 26 Jun 2018 11:25:29 +0200
Subject: [PATCH v2 05/13] clk: davinci: psc-da830: add a lookup entry for
 aemif clock
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Message-ID: <20180626092537.6737-6-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to use the ti-aemif platform driver for da830-evm. To make it
work we need a lookup entry for the aemif clock.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc-da830.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-da830.c b/drivers/clk/davinci/psc-da830.c
index 081b039fcb02..6481337382a6 100644
--- a/drivers/clk/davinci/psc-da830.c
+++ b/drivers/clk/davinci/psc-da830.c
@@ -14,6 +14,7 @@
 
 #include "psc.h"
 
+LPSC_CLKDEV1(aemif_clkdev,	NULL,	"ti-aemif");
 LPSC_CLKDEV1(spi0_clkdev,	NULL,	"spi_davinci.0");
 LPSC_CLKDEV1(mmcsd_clkdev,	NULL,	"da830-mmc.0");
 LPSC_CLKDEV1(uart0_clkdev,	NULL,	"serial8250.0");
@@ -22,7 +23,7 @@ static const struct davinci_lpsc_clk_info da830_psc0_info[] = {
 	LPSC(0,  0, tpcc,     pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
 	LPSC(1,  0, tptc0,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
 	LPSC(2,  0, tptc1,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(3,  0, aemif,    pll0_sysclk3, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(3,  0, aemif,    pll0_sysclk3, aemif_clkdev, LPSC_ALWAYS_ENABLED),
 	LPSC(4,  0, spi0,     pll0_sysclk2, spi0_clkdev,  0),
 	LPSC(5,  0, mmcsd,    pll0_sysclk2, mmcsd_clkdev, 0),
 	LPSC(6,  0, aintc,    pll0_sysclk4, NULL,         LPSC_ALWAYS_ENABLED),
-- 
2.17.1
