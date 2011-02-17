From: yong.shen@linaro.org (yong.shen at linaro.org)
Date: Thu, 17 Feb 2011 10:01:39 +0100
Subject: [PATCH v3 3/3] ARM: IMX5 bbg: add cpuidle parameters
In-Reply-To: <1297933299-30367-1-git-send-email-yong.shen@linaro.org>
References: <1297933299-30367-1-git-send-email-yong.shen@linaro.org>
Message-ID: <1297933299-30367-4-git-send-email-yong.shen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

This parameters are workable, but need further tuning.

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index d9d402e..bb6fda0 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -37,6 +37,7 @@
 #include "devices-imx51.h"
 #include "devices.h"
 #include "cpu_op-mx51.h"
+#include "cpuidle.h"
 
 #define BABBAGE_USB_HUB_RESET	IMX_GPIO_NR(1, 7)
 #define BABBAGE_USBH1_STP	IMX_GPIO_NR(1, 27)
@@ -333,6 +334,11 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
 };
 
+static struct mx5_cpuidle_params babbage_cpuidle_params[] = {
+	{100,},
+	{150,},
+	{1000,},
+};
 /*
  * Board specific initialization.
  */
@@ -383,6 +389,8 @@ static void __init mxc_board_init(void)
 		ARRAY_SIZE(mx51_babbage_spi_board_info));
 	imx51_add_ecspi(0, &mx51_babbage_spi_pdata);
 	imx51_add_imx2_wdt(0, NULL);
+
+	mx5_cpuidle_board_params(babbage_cpuidle_params);
 }
 
 static void __init mx51_babbage_timer_init(void)
-- 
1.7.1
