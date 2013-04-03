From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Wed, 3 Apr 2013 19:39:06 +0530
Subject: [PATCH v5 1/5] spi/davinci: no wildcards in DT compatible property
In-Reply-To: <1364998150-5980-1-git-send-email-prakash.pm@ti.com>
References: <1364998150-5980-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1364998150-5980-2-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow DT naming convention for compatible property of the blob.
Use first chip name that introduced the specific version of the
device.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 drivers/spi/spi-davinci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 8234d22..2e8f24a 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -776,10 +776,10 @@ rx_dma_failed:
 #if defined(CONFIG_OF)
 static const struct of_device_id davinci_spi_of_match[] = {
 	{
-		.compatible = "ti,dm644x-spi",
+		.compatible = "ti,dm6441-spi",
 	},
 	{
-		.compatible = "ti,da8xx-spi",
+		.compatible = "ti,da830-spi",
 		.data = (void *)SPI_VERSION_2,
 	},
 	{ },
-- 
1.7.4.1
