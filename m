From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Wed,  2 Mar 2011 08:11:05 +0000
Subject: [PATCH] MX1: Add structure,
	registration functions for framebuffer and rename LCDC INT
Message-ID: <1299053465-99879-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/mach-imx/devices-imx1.h            |    4 ++++
 arch/arm/plat-mxc/devices/platform-imx-fb.c |    5 +++++
 arch/arm/plat-mxc/include/mach/mx1.h        |    2 +-
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
index fd26715..da59365 100644
--- a/arch/arm/mach-imx/devices-imx1.h
+++ b/arch/arm/mach-imx/devices-imx1.h
@@ -9,6 +9,10 @@
 #include <mach/mx1.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_imx_fb_data imx1_imx_fb_data __initconst;
+#define imx1_add_imx_fb(pdata) \
+    imx_add_imx_fb(&imx1_imx_fb_data, pdata)
+
 extern const struct imx_imx_i2c_data imx1_imx_i2c_data __initconst;
 #define imx1_add_imx_i2c(pdata)		\
 	imx_add_imx_i2c(&imx1_imx_i2c_data, pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-fb.c b/arch/arm/plat-mxc/devices/platform-imx-fb.c
index 6100a7d..79a1cb1 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-fb.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-fb.c
@@ -16,6 +16,11 @@
 		.irq = soc ## _INT_LCDC,				\
 	}
 
+#ifdef CONFIG_SOC_IMX1
+const struct imx_imx_fb_data imx1_imx_fb_data __initconst =
+	imx_imx_fb_data_entry_single(MX1, SZ_4K);
+#endif /* ifdef CONFIG_SOC_IMX1 */
+
 #ifdef CONFIG_SOC_IMX21
 const struct imx_imx_fb_data imx21_imx_fb_data __initconst =
 	imx_imx_fb_data_entry_single(MX21, SZ_4K);
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index 7c871b8..97b19e7 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -89,7 +89,7 @@
 #define MX1_GPIO_INT_PORTA	11
 #define MX1_GPIO_INT_PORTB	12
 #define MX1_GPIO_INT_PORTC	13
-#define MX1_LCDC_INT		14
+#define MX1_INT_LCDC		14
 #define MX1_SIM_INT		15
 #define MX1_SIM_DATA_INT	16
 #define MX1_RTC_INT		17
-- 
1.7.3.4
