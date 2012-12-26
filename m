From: Barry.Song@csr.com (Barry Song)
Date: Wed, 26 Dec 2012 10:30:17 +0800
Subject: [PATCH 2/2] i2c: sirf: add support for new SiRFmarco SMP SoC
In-Reply-To: <1356489017-17737-1-git-send-email-Barry.Song@csr.com>
References: <1356489017-17737-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1356489017-17737-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

the driver is also compatible with SiRFmarco except SiRFprimaII,
so simply add "sirf,marco-i2c" to OF match table.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/i2c/busses/i2c-sirf.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 181d7c2..ed38b16 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -439,6 +439,7 @@ static const struct dev_pm_ops i2c_sirfsoc_pm_ops = {
 
 static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst = {
 	{ .compatible = "sirf,prima2-i2c", },
+	{ .compatible = "sirf,marco-i2c", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sirfsoc_i2c_of_match);
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
