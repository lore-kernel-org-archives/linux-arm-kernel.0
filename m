From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 14:38:27 +0100
Subject: [PATCH 2/6] cpuimx51sd: add cpufreq support
In-Reply-To: <1298641111-12957-1-git-send-email-eric@eukrea.com>
References: <1298641111-12957-1-git-send-email-eric@eukrea.com>
Message-ID: <1298641111-12957-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/board-cpuimx51sd.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index b89afba..68ecfc0 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -42,6 +42,7 @@
 
 #include "devices-imx51.h"
 #include "devices.h"
+#include "cpu_op-mx51.h"
 
 #define USBH1_RST		IMX_GPIO_NR(2, 28)
 #define ETH_RST			IMX_GPIO_NR(2, 31)
@@ -269,6 +270,10 @@ static void __init eukrea_cpuimx51sd_init(void)
 	mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx51sd_pads,
 					ARRAY_SIZE(eukrea_cpuimx51sd_pads));
 
+#if defined(CONFIG_CPU_FREQ_IMX)
+	get_cpu_op = mx51_get_cpu_op;
+#endif
+
 	imx51_add_imx_uart(0, &uart_pdata);
 	imx51_add_mxc_nand(&eukrea_cpuimx51sd_nand_board_info);
 
-- 
1.7.4
