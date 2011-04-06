From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  6 Apr 2011 16:38:36 +0200
Subject: [PATCH] ARM: imx51: use platform id 2 for imx51-cspi
Message-ID: <1302100716-21034-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform id is used to determine the spi bus number, so it should
better be different to the ids used for imx51-ecspi.  Otherwise it's not
possible to use both devices "imx51-cspi.0" and "imx51-ecspi.0".

Alternative approaches are to use dynamic bus numbering as offered by
the spi framework or let the machine code set the bus number.  The
downside of both possibilities is that the bus number isn't fixed for
the same busses on different machines using i.MX51.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices/platform-spi_imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index f4a60ab..f97eb36 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -80,7 +80,7 @@ const struct imx_spi_imx_data imx35_cspi_data[] __initconst = {
 
 #ifdef CONFIG_SOC_IMX51
 const struct imx_spi_imx_data imx51_cspi_data __initconst =
-	imx_spi_imx_data_entry_single(MX51, CSPI, "imx51-cspi", 0, , SZ_4K);
+	imx_spi_imx_data_entry_single(MX51, CSPI, "imx51-cspi", 2, , SZ_4K);
 
 const struct imx_spi_imx_data imx51_ecspi_data[] __initconst = {
 #define imx51_ecspi_data_entry(_id, _hwid)				\
-- 
1.7.2.3
