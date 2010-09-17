From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 17 Sep 2010 11:54:25 +0200
Subject: [PATCH 07/16] ARM: imx: use platform ids for spi_imx devices
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
Message-ID: <1284717274-12850-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver recently learned to handle platform ids.  Make use of this
new feature.  The up side is that the driver needs less knowledge about
the spi interfaces used on different SoCs.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/clock-imx1.c                  |    2 +-
 arch/arm/mach-imx/clock-imx21.c                 |    6 +++---
 arch/arm/mach-imx/clock-imx27.c                 |    6 +++---
 arch/arm/mach-mx25/clock.c                      |    6 +++---
 arch/arm/mach-mx3/clock-imx31.c                 |    6 +++---
 arch/arm/mach-mx3/clock-imx35.c                 |    4 ++--
 arch/arm/plat-mxc/devices/platform-spi_imx.c    |    3 ++-
 arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
 8 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx/clock-imx1.c
index c05096c..daca30b 100644
--- a/arch/arm/mach-imx/clock-imx1.c
+++ b/arch/arm/mach-imx/clock-imx1.c
@@ -592,7 +592,7 @@ static struct clk_lookup lookups[] __initdata = {
 	_REGISTER_CLOCK("imx-uart.1", NULL, uart_clk)
 	_REGISTER_CLOCK("imx-uart.2", NULL, uart_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
-	_REGISTER_CLOCK("spi_imx.0", NULL, spi_clk)
+	_REGISTER_CLOCK("imx1-cspi.0", NULL, spi_clk)
 	_REGISTER_CLOCK("imx-mmc.0", NULL, sdhc_clk)
 	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
 	_REGISTER_CLOCK(NULL, "mshc", mshc_clk)
diff --git a/arch/arm/mach-imx/clock-imx21.c b/arch/arm/mach-imx/clock-imx21.c
index bb419ef..cf15ea5 100644
--- a/arch/arm/mach-imx/clock-imx21.c
+++ b/arch/arm/mach-imx/clock-imx21.c
@@ -1172,9 +1172,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "pwm", pwm_clk[0])
 	_REGISTER_CLOCK(NULL, "sdhc1", sdhc_clk[0])
 	_REGISTER_CLOCK(NULL, "sdhc2", sdhc_clk[1])
-	_REGISTER_CLOCK(NULL, "cspi1", cspi_clk[0])
-	_REGISTER_CLOCK(NULL, "cspi2", cspi_clk[1])
-	_REGISTER_CLOCK(NULL, "cspi3", cspi_clk[2])
+	_REGISTER_CLOCK("imx21-cspi.0", NULL, cspi_clk[0])
+	_REGISTER_CLOCK("imx21-cspi.1", NULL, cspi_clk[1])
+	_REGISTER_CLOCK("imx21-cspi.2", NULL, cspi_clk[2])
 	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk[0])
 	_REGISTER_CLOCK(NULL, "csi", csi_clk[0])
 	_REGISTER_CLOCK("imx21-hcd.0", NULL, usb_clk[0])
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 5a1aa15..07bf315 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -640,9 +640,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc1_clk)
 	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc2_clk)
 	_REGISTER_CLOCK("mxc-mmc.2", NULL, sdhc3_clk)
-	_REGISTER_CLOCK("spi_imx.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("spi_imx.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("spi_imx.2", NULL, cspi3_clk)
+	_REGISTER_CLOCK("imx27-cspi.0", NULL, cspi1_clk)
+	_REGISTER_CLOCK("imx27-cspi.1", NULL, cspi2_clk)
+	_REGISTER_CLOCK("imx27-cspi.2", NULL, cspi3_clk)
 	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
 	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk)
diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 40c7cc4..039464a 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -261,9 +261,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
 	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
-	_REGISTER_CLOCK("spi_imx.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("spi_imx.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("spi_imx.2", NULL, cspi3_clk)
+	_REGISTER_CLOCK("imx25-cspi.0", NULL, cspi1_clk)
+	_REGISTER_CLOCK("imx25-cspi.1", NULL, cspi2_clk)
+	_REGISTER_CLOCK("imx25-cspi.2", NULL, cspi3_clk)
 	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
 	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
 	_REGISTER_CLOCK("mxc_pwm.2", NULL, pwm3_clk)
diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
index 9a9eb6d..18e98f1 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-mx3/clock-imx31.c
@@ -525,9 +525,9 @@ DEFINE_CLOCK(ipg_clk,     0, NULL,          0, ipg_get_rate, NULL, &ahb_clk);
 
 static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "emi", emi_clk)
-	_REGISTER_CLOCK("spi_imx.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("spi_imx.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("spi_imx.2", NULL, cspi3_clk)
+	_REGISTER_CLOCK("imx31-cspi.0", NULL, cspi1_clk)
+	_REGISTER_CLOCK("imx31-cspi.1", NULL, cspi2_clk)
+	_REGISTER_CLOCK("imx31-cspi.2", NULL, cspi3_clk)
 	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
 	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
 	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index f11ef99..708c2b3 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -451,8 +451,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "ata", ata_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
-	_REGISTER_CLOCK("spi_imx.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("spi_imx.1", NULL, cspi2_clk)
+	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi1_clk)
+	_REGISTER_CLOCK("imx35-cspi.1", NULL, cspi2_clk)
 	_REGISTER_CLOCK(NULL, "ect", ect_clk)
 	_REGISTER_CLOCK(NULL, "edio", edio_clk)
 	_REGISTER_CLOCK(NULL, "emi", emi_clk)
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index 412a81f..bd30d4b 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -11,6 +11,7 @@
 
 #define imx_spi_imx_data_entry_single(soc, type, _devid, _id, hwid, _size) \
 	{								\
+		.devid = _devid,					\
 		.id = _id,						\
 		.iobase = soc ## _ ## type ## hwid ## _BASE_ADDR,	\
 		.iosize = _size,					\
@@ -83,6 +84,6 @@ struct platform_device *__init imx_add_spi_imx(
 		},
 	};
 
-	return imx_add_platform_device("spi_imx", data->id,
+	return imx_add_platform_device(data->devid, data->id,
 			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index abe12c29..dbb9b47 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -56,6 +56,7 @@ struct platform_device *__init imx_add_mxc_nand_v21(resource_size_t iobase,
 
 #include <mach/spi.h>
 struct imx_spi_imx_data {
+	const char *devid;
 	int id;
 	resource_size_t iobase;
 	resource_size_t iosize;
-- 
1.7.2.3
