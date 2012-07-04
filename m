From: Barry.Song@csr.com (Barry Song)
Date: Wed, 4 Jul 2012 17:00:41 +0800
Subject: [PATCH] SPI: SIRF: replace -EINVAL by PTR_ERR(clk) when clk_get fails
Message-ID: <1341392441-619-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

With this patch, the ret value will be more meaningful.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index ecc3d97..0b10e4f 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -567,7 +567,7 @@ static int __devinit spi_sirfsoc_probe(struct platform_device *pdev)
 
 	sspi->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sspi->clk)) {
-		ret = -EINVAL;
+		ret = PTR_ERR(sspi->clk);
 		goto free_pin;
 	}
 	clk_enable(sspi->clk);
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
