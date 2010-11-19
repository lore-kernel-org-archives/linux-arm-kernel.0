From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 19 Nov 2010 10:55:53 -0500
Subject: [PATCH v6 09/12] davinci: add tnetv107x evm ti-ssp gpio device
In-Reply-To: <1290182156-20104-1-git-send-email-cyril@ti.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
Message-ID: <1290182156-20104-10-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds definitions to hook up one of the ti-ssp ports to the SSP GPIO
driver.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index ca23516..e3863dd 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -39,6 +39,8 @@
 #include <mach/cp_intc.h>
 #include <mach/tnetv107x.h>
 
+#define SSP_GPIO_START		128
+
 #define EVM_MMC_WP_GPIO		21
 #define EVM_MMC_CD_GPIO		24
 #define EVM_SPI_CS_GPIO		54
@@ -238,9 +240,18 @@ static struct ti_ssp_spi_data spi_master_data = {
 		  SSP_INPUT_SEL(3),
 };
 
+static struct ti_ssp_gpio_data ssp_gpio_data = {
+	.start		= SSP_GPIO_START,
+};
+
 static struct ti_ssp_data ssp_config = {
 	.out_clock	= 250 * 1000,
 	.dev_data	= {
+		[0] = {
+			.dev_name = "ti-ssp-gpio",
+			.pdata = &ssp_gpio_data,
+			.pdata_size = sizeof(ssp_gpio_data),
+		},
 		[1] = {
 			.dev_name = "ti-ssp-spi",
 			.pdata = &spi_master_data,
-- 
1.7.1
