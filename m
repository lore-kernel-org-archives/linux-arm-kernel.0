From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 13:49:14 +0100
Subject: [PATCH 1/2] eukrea_mbimxsd25-baseboard: add SD card detect
Message-ID: <1298638155-4128-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index cb705c2..6269053 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -34,6 +34,7 @@
 #include <mach/mx25.h>
 #include <mach/imx-uart.h>
 #include <mach/audmux.h>
+#include <mach/esdhc.h>
 
 #include "devices-imx25.h"
 
@@ -242,6 +243,11 @@ struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
 	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
 };
 
+static struct esdhc_platform_data sd1_pdata = {
+	.cd_gpio = GPIO_SD1CD,
+	.wp_gpio = -EINVAL,
+};
+
 /*
  * system init for baseboard usage. Will be called by cpuimx25 init.
  *
@@ -275,7 +281,7 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 	imx25_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
 	imx25_add_flexcan1(NULL);
-	imx25_add_sdhci_esdhc_imx(0, NULL);
+	imx25_add_sdhci_esdhc_imx(0, &sd1_pdata);
 
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
-- 
1.7.4
