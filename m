From: chiau.ee.chew@intel.com (Chew Chiau Ee)
Date: Fri, 29 Nov 2013 02:13:11 +0800
Subject: [PATCH] spi/pxa2xx: Restore private register bits.
Message-ID: <1385662391-27573-1-git-send-email-chiau.ee.chew@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chew, Chiau Ee <chiau.ee.chew@intel.com>

The Intel LPSS SPI private register bits have to be restored
when system resume from S3 suspend.

Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 7028180..7765b19 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1293,6 +1293,9 @@ static int pxa2xx_spi_resume(struct device *dev)
 	/* Enable the SSP clock */
 	clk_prepare_enable(ssp->clk);
 
+	/* Restore LPSS private register bits */
+	lpss_ssp_setup(drv_data);
+
 	/* Start the queue running */
 	status = spi_master_resume(drv_data->master);
 	if (status != 0) {
-- 
1.7.4.4
