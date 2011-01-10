From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Mon, 10 Jan 2011 20:08:52 +0800
Subject: [PATCH 1/3] ARM i.MX SPI driver changes for i.MX53 support
Message-ID: <1294661334-7826-1-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

1. Change the Kconfig to include i.MX53
2. add devtype entry for i.MX53

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 drivers/spi/Kconfig   |    4 ++--
 drivers/spi/spi_imx.c |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 78f9fd0..04965e2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -153,10 +153,10 @@ config SPI_IMX_VER_0_4
 	def_bool y if ARCH_MX31
 
 config SPI_IMX_VER_0_7
-	def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51
+	def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51 || ARCH_MX53
 
 config SPI_IMX_VER_2_3
-	def_bool y if ARCH_MX51
+	def_bool y if ARCH_MX51 || ARCH_MX53
 
 config SPI_IMX
 	tristate "Freescale i.MX SPI controllers"
diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 55a38e2..9b8a733 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -747,6 +747,12 @@ static struct platform_device_id spi_imx_devtype[] = {
 		.name = "imx51-ecspi",
 		.driver_data = SPI_IMX_VER_2_3,
 	}, {
+		.name = "imx53-cspi",
+		.driver_data = SPI_IMX_VER_0_7,
+	}, {
+		.name = "imx53-ecspi",
+		.driver_data = SPI_IMX_VER_2_3,
+	}, {
 		/* sentinel */
 	}
 };
-- 
1.7.1
