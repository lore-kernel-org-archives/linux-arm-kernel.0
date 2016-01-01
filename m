From: geliangtang@163.com (Geliang Tang)
Date: Fri,  1 Jan 2016 20:29:00 +0800
Subject: [PATCH 2/2 v2] spi: zynq: use to_platform_device()
In-Reply-To: <80986828f7ac394fef839514fbbc78ce0b18a675.1451650817.git.geliangtang@163.com>
References: <80986828f7ac394fef839514fbbc78ce0b18a675.1451650817.git.geliangtang@163.com>
Message-ID: <ef19dceeb9e5175b59d2d875f7fad4cd59ca4ff0.1451650817.git.geliangtang@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
---
Changes in v2:
 - split from 'spi: cadence, zynq: use to_platform_device()'
---
 drivers/spi/spi-zynqmp-gqspi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index f23f36e..aab9b49 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -917,9 +917,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
  */
 static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-						    struct platform_device,
-						    dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
 
 	spi_master_suspend(master);
@@ -940,9 +938,7 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
  */
 static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-						    struct platform_device,
-						    dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
 	int ret = 0;
-- 
2.5.0
