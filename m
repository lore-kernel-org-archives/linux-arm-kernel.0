From: richard.zhu@linaro.org (Richard Zhu)
Date: Mon, 29 Aug 2011 15:18:56 +0800
Subject: [PATCH V6 3/5] MX53 Enable the AHCI SATA on MX53 ARD board
In-Reply-To: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
Message-ID: <1314602339-18392-3-git-send-email-richard.zhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/board-mx53_ard.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 76a67c4..d265cee 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -27,6 +27,7 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx53.h>
+#include <mach/ahci_sata.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -220,6 +221,11 @@ static struct platform_device *devices[] __initdata = {
 	&ard_smsc_lan9220_device,
 };
 
+static struct ahci_platform_data sata_data = {
+	.init = sata_init,
+	.exit = sata_exit,
+};
+
 static void __init mx53_ard_board_init(void)
 {
 	imx53_soc_init();
@@ -234,6 +240,7 @@ static void __init mx53_ard_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
 	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
 	imx_add_gpio_keys(&ard_button_data);
+	imx53_add_ahci_imx(0, &sata_data);
 }
 
 static void __init mx53_ard_timer_init(void)
-- 
1.7.1
