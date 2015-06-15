From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 15 Jun 2015 09:18:56 -0700
Subject: [PATCH 01/10] dma: imx-sdma: constify local structs
In-Reply-To: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
References: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1434385144-4432-2-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/dma/imx-sdma.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d0df198..0671d6d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -310,7 +310,7 @@ struct sdma_firmware_header {
 struct sdma_driver_data {
 	int chnenbl0;
 	int num_events;
-	struct sdma_script_start_addrs	*script_addrs;
+	const struct sdma_script_start_addrs	*script_addrs;
 };
 
 struct sdma_engine {
@@ -335,7 +335,7 @@ static struct sdma_driver_data sdma_imx31 = {
 	.num_events = 32,
 };
 
-static struct sdma_script_start_addrs sdma_script_imx25 = {
+static const struct sdma_script_start_addrs sdma_script_imx25 = {
 	.ap_2_ap_addr = 729,
 	.uart_2_mcu_addr = 904,
 	.per_2_app_addr = 1255,
@@ -351,18 +351,18 @@ static struct sdma_script_start_addrs sdma_script_imx25 = {
 	.shp_2_mcu_addr = 979,
 };
 
-static struct sdma_driver_data sdma_imx25 = {
+static const struct sdma_driver_data sdma_imx25 = {
 	.chnenbl0 = SDMA_CHNENBL0_IMX35,
 	.num_events = 48,
 	.script_addrs = &sdma_script_imx25,
 };
 
-static struct sdma_driver_data sdma_imx35 = {
+static const struct sdma_driver_data sdma_imx35 = {
 	.chnenbl0 = SDMA_CHNENBL0_IMX35,
 	.num_events = 48,
 };
 
-static struct sdma_script_start_addrs sdma_script_imx51 = {
+static const struct sdma_script_start_addrs sdma_script_imx51 = {
 	.ap_2_ap_addr = 642,
 	.uart_2_mcu_addr = 817,
 	.mcu_2_app_addr = 747,
@@ -375,13 +375,13 @@ static struct sdma_script_start_addrs sdma_script_imx51 = {
 	.shp_2_mcu_addr = 892,
 };
 
-static struct sdma_driver_data sdma_imx51 = {
+static const struct sdma_driver_data sdma_imx51 = {
 	.chnenbl0 = SDMA_CHNENBL0_IMX35,
 	.num_events = 48,
 	.script_addrs = &sdma_script_imx51,
 };
 
-static struct sdma_script_start_addrs sdma_script_imx53 = {
+static const struct sdma_script_start_addrs sdma_script_imx53 = {
 	.ap_2_ap_addr = 642,
 	.app_2_mcu_addr = 683,
 	.mcu_2_app_addr = 747,
@@ -395,13 +395,13 @@ static struct sdma_script_start_addrs sdma_script_imx53 = {
 	.mcu_2_firi_addr = 1290,
 };
 
-static struct sdma_driver_data sdma_imx53 = {
+static const struct sdma_driver_data sdma_imx53 = {
 	.chnenbl0 = SDMA_CHNENBL0_IMX35,
 	.num_events = 48,
 	.script_addrs = &sdma_script_imx53,
 };
 
-static struct sdma_script_start_addrs sdma_script_imx6q = {
+static const struct sdma_script_start_addrs sdma_script_imx6q = {
 	.ap_2_ap_addr = 642,
 	.uart_2_mcu_addr = 817,
 	.mcu_2_app_addr = 747,
@@ -414,13 +414,13 @@ static struct sdma_script_start_addrs sdma_script_imx6q = {
 	.mcu_2_spdif_addr = 1134,
 };
 
-static struct sdma_driver_data sdma_imx6q = {
+static const struct sdma_driver_data sdma_imx6q = {
 	.chnenbl0 = SDMA_CHNENBL0_IMX35,
 	.num_events = 48,
 	.script_addrs = &sdma_script_imx6q,
 };
 
-static struct platform_device_id sdma_devtypes[] = {
+static const struct platform_device_id sdma_devtypes[] = {
 	{
 		.name = "imx25-sdma",
 		.driver_data = (unsigned long)&sdma_imx25,
-- 
2.1.4
