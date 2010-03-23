From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Tue, 23 Mar 2010 19:50:28 +0100
Subject: [PATCH 3/8] MXC: mach-mx31_3ds: Add SPI1 device support.
In-Reply-To: <1269370175.3276.168.camel@realization>
References: <1269369741.3276.162.camel@realization>
	<1269370017.3276.165.camel@realization>
	<1269370175.3276.168.camel@realization>
Message-ID: <1269370228.3276.169.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index bf1f54a..80179cf 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -35,6 +35,7 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/mxc_nand.h>
+#include <mach/spi.h>
 #include "devices.h"
 
 /*!
@@ -52,6 +53,24 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_TXD1__TXD1,
 	MX31_PIN_RXD1__RXD1,
 	IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO),
+	/* SPI 1 */
+	MX31_PIN_CSPI2_SCLK__SCLK,
+	MX31_PIN_CSPI2_MOSI__MOSI,
+	MX31_PIN_CSPI2_MISO__MISO,
+	MX31_PIN_CSPI2_SPI_RDY__SPI_RDY,
+	MX31_PIN_CSPI2_SS0__SS0,
+	MX31_PIN_CSPI2_SS2__SS2, /*CS for MC13783 */
+};
+
+/* SPI */
+static int spi1_internal_chipselect[] = {
+	MXC_SPI_CS(0),
+	MXC_SPI_CS(2),
+};
+
+static struct spi_imx_master spi1_pdata = {
+	.chipselect	= spi1_internal_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi1_internal_chipselect),
 };
 
 /*
@@ -249,6 +268,7 @@ static void __init mxc_board_init(void)
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxc_nand_device, &imx31_3ds_nand_flash_pdata);
+	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
 
 	if (!mx31_3ds_init_expio())
 		platform_device_register(&smsc911x_device);
-- 
1.6.3.3
