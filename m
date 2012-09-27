From: Barry.Song@csr.com (Barry Song)
Date: Thu, 27 Sep 2012 17:55:46 +0800
Subject: [PATCH 4/6] pinctrl: sirf: initialize the irq_chip pointer of
 pinctrl_gpio_range
Message-ID: <1348739746-21184-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

This patch initializes the optional irq_chip pointer gc in sirfsoc
pinctrl_gpio_range.

Signed-off-by: Baohua Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/pinctrl-sirf.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 6eae934..9a984e8 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1266,8 +1266,10 @@ static int __devinit sirfsoc_pinmux_probe(struct platform_device *pdev)
 		goto out_no_pmx;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(sirfsoc_gpio_ranges); i++)
+	for (i = 0; i < ARRAY_SIZE(sirfsoc_gpio_ranges); i++) {
+		sirfsoc_gpio_ranges[i].gc = &sgpio_bank[i].chip.gc;
 		pinctrl_add_gpio_range(spmx->pmx, &sirfsoc_gpio_ranges[i]);
+	}
 
 	dev_info(&pdev->dev, "initialized SIRFSOC pinmux driver\n");
 
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
