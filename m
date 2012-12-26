From: Barry.Song@csr.com (Barry Song)
Date: Wed, 26 Dec 2012 10:48:34 +0800
Subject: [PATCH 2/2] spi: sirf: add support for new SiRFmarco SMP SoC
In-Reply-To: <1356490114-18022-1-git-send-email-Barry.Song@csr.com>
References: <1356490114-18022-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1356490114-18022-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

the driver is also compatible with SiRFmarco except SiRFprimaII,
so simply add "sirf,marco-spi" to OF match table.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 38a191c..09ca0e3 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -659,6 +659,7 @@ static const struct dev_pm_ops spi_sirfsoc_pm_ops = {
 
 static const struct of_device_id spi_sirfsoc_of_match[] = {
 	{ .compatible = "sirf,prima2-spi", },
+	{ .compatible = "sirf,marco-spi", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sirfsoc_spi_of_match);
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
