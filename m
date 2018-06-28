From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 28 Jun 2018 11:57:39 +0200
Subject: [PATCH v3 04/13] clk: davinci: psc-dm646x: use two lookup entries for
 the aemif clock
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
Message-ID: <20180628095748.4462-5-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to be able to get the clock both from the board file by its
con_id and from the aemif driver by dev_id.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/psc-dm646x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-dm646x.c b/drivers/clk/davinci/psc-dm646x.c
index c3f82ed70a80..20012dc7471a 100644
--- a/drivers/clk/davinci/psc-dm646x.c
+++ b/drivers/clk/davinci/psc-dm646x.c
@@ -18,7 +18,8 @@
 LPSC_CLKDEV1(ide_clkdev,	NULL,		"palm_bk3710");
 LPSC_CLKDEV2(emac_clkdev,	NULL,		"davinci_emac.1",
 				"fck",		"davinci_mdio.0");
-LPSC_CLKDEV1(aemif_clkdev,	"aemif",	NULL);
+LPSC_CLKDEV2(aemif_clkdev,	"aemif",	NULL,
+				NULL,		"ti-aemif");
 LPSC_CLKDEV1(mcasp0_clkdev,	NULL,		"davinci-mcasp.0");
 LPSC_CLKDEV1(mcasp1_clkdev,	NULL,		"davinci-mcasp.1");
 LPSC_CLKDEV1(uart0_clkdev,	NULL,		"serial8250.0");
-- 
2.17.1
