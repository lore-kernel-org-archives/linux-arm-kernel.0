From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 26 Jun 2018 11:25:27 +0200
Subject: [PATCH v2 03/13] clk: davinci: psc-dm644x: use two lookup entries for
 the aemif clock
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Message-ID: <20180626092537.6737-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to be able to get the clock both from the board file by its
con_id and from the aemif driver by dev_id.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc-dm644x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-dm644x.c b/drivers/clk/davinci/psc-dm644x.c
index fc0230e3a3d6..0cea6e0bd5f0 100644
--- a/drivers/clk/davinci/psc-dm644x.c
+++ b/drivers/clk/davinci/psc-dm644x.c
@@ -21,7 +21,8 @@ LPSC_CLKDEV2(emac_clkdev,		NULL,		"davinci_emac.1",
 					"fck",		"davinci_mdio.0");
 LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
 LPSC_CLKDEV1(ide_clkdev,		NULL,		"palm_bk3710");
-LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
+LPSC_CLKDEV2(aemif_clkdev,		"aemif",	NULL,
+					NULL,		"ti-aemif");
 LPSC_CLKDEV1(mmcsd_clkdev,		NULL,		"dm6441-mmc.0");
 LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
 LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
-- 
2.17.1
