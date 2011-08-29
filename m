From: richard.zhu@linaro.org (Richard Zhu)
Date: Mon, 29 Aug 2011 15:18:58 +0800
Subject: [PATCH V6 5/5] MX53 Enable the AHCI SATA on MX53 SMD board
In-Reply-To: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
Message-ID: <1314602339-18392-5-git-send-email-richard.zhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/board-mx53_smd.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index bc02894..1cea06b 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -26,6 +26,7 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx53.h>
+#include <mach/ahci_sata.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -111,6 +112,11 @@ static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+static struct ahci_platform_data sata_data = {
+	.init = sata_init,
+	.exit = sata_exit,
+};
+
 static void __init mx53_smd_board_init(void)
 {
 	imx53_soc_init();
@@ -125,6 +131,7 @@ static void __init mx53_smd_board_init(void)
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(1, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
+	imx53_add_ahci_imx(0, &sata_data);
 }
 
 static void __init mx53_smd_timer_init(void)
-- 
1.7.1
