From: Barry.Song@csr.com (Barry Song)
Date: Tue, 2 Sep 2014 17:02:35 +0800
Subject: [PATCH 6/8] spi: sirf: set default spi frequency if it is not set
In-Reply-To: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1409648557-5470-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

give spi a default frequence if it is not set and the value is 0.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 7499076..74835c2 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -134,6 +134,7 @@
 	ALIGNED(x->len) && (x->len < 2 * PAGE_SIZE))
 
 #define SIRFSOC_MAX_CMD_BYTES	4
+#define SIRFSOC_SPI_DEFAULT_FREQ 1000000
 
 struct sirfsoc_spi {
 	struct spi_bitbang bitbang;
@@ -630,7 +631,7 @@ static int spi_sirfsoc_setup(struct spi_device *spi)
 	struct sirfsoc_spi *sspi;
 	int ret = 0;
 	if (!spi->max_speed_hz)
-		return -EINVAL;
+		spi->max_speed_hz = SIRFSOC_SPI_DEFAULT_FREQ;
 
 	sspi = spi_master_get_devdata(spi->master);
 
-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
