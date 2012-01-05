From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  5 Jan 2012 19:33:08 -0200
Subject: [PATCH] ARM: imx: iomux-v1.h: Fix build error due to __init annotation
Message-ID: <1325799188-24921-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build error found when building imx_v4_v5_defconfig:

  CC      arch/arm/mach-imx/mach-imx27ipcam.o
In file included from arch/arm/plat-mxc/include/mach/iomux-mx27.h:23,
                 from arch/arm/mach-imx/mach-imx27ipcam.c:22:
arch/arm/plat-mxc/include/mach/iomux-v1.h:99: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'imx_iomuxv1_init'

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This applies against linux-next

 arch/arm/plat-mxc/include/mach/iomux-v1.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-v1.h b/arch/arm/plat-mxc/include/mach/iomux-v1.h
index 6fa8a70..f7d1804 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v1.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v1.h
@@ -96,6 +96,6 @@ extern int mxc_gpio_mode(int gpio_mode);
 extern int mxc_gpio_setup_multiple_pins(const int *pin_list, unsigned count,
 		const char *label);
 
-extern int __init imx_iomuxv1_init(void __iomem *base, int numports);
+extern int imx_iomuxv1_init(void __iomem *base, int numports);
 
 #endif /* __MACH_IOMUX_V1_H__ */
-- 
1.7.1
