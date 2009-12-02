From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 02 Dec 2009 21:53:13 +0800
Subject: [PATCH 2/4]ARM: NUC900: add clk definition support for nuc932
Message-ID: <4B167149.50809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

This patch adds clk definition support for nuc932.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 arch/arm/mach-w90x900/nuc932.c |   47 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/nuc932.c b/arch/arm/mach-w90x900/nuc932.c
index 6ad68aa..140fa2f 100644
--- a/arch/arm/mach-w90x900/nuc932.c
+++ b/arch/arm/mach-w90x900/nuc932.c
@@ -14,11 +14,58 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
 #include "cpu.h"
 
+/* Initial nuc932 clock declarations. */
+static DEFINE_CLK(audio, 2);
+static DEFINE_CLK(sd, 3);
+static DEFINE_CLK(jpg, 4);
+static DEFINE_CLK(video, 5);
+static DEFINE_CLK(vpost, 6);
+static DEFINE_CLK(2d, 7);
+static DEFINE_CLK(gpu, 8);
+static DEFINE_CLK(gdma, 9);
+static DEFINE_CLK(adc, 10);
+static DEFINE_CLK(uart, 11);
+static DEFINE_CLK(spi, 12);
+static DEFINE_CLK(pwm, 13);
+static DEFINE_CLK(timer, 14);
+static DEFINE_CLK(wdt, 15);
+static DEFINE_CLK(ac97, 16);
+static DEFINE_CLK(i2s, 16);
+static DEFINE_CLK(usbck, 17);
+static DEFINE_CLK(usb48, 18);
+static DEFINE_CLK(usbh, 19);
+static DEFINE_CLK(i2c, 20);
+static DEFINE_CLK(ext, 0);
+
 static struct clk_lookup nuc932_clkregs[] = {
+	DEF_CLKLOOK(&clk_audio, "nuc932-audio", NULL),
+	DEF_CLKLOOK(&clk_sd, "nuc932-sd", NULL),
+	DEF_CLKLOOK(&clk_jpg, "nuc932-jpg", "NULL"),
+	DEF_CLKLOOK(&clk_video, "nuc932-video", "NULL"),
+	DEF_CLKLOOK(&clk_vpost, "nuc932-vpost", NULL),
+	DEF_CLKLOOK(&clk_2d, "nuc932-2d", NULL),
+	DEF_CLKLOOK(&clk_gpu, "nuc932-gpu", NULL),
+	DEF_CLKLOOK(&clk_gdma, "nuc932-gdma", "NULL"),
+	DEF_CLKLOOK(&clk_adc, "nuc932-adc", NULL),
+	DEF_CLKLOOK(&clk_uart, NULL, "uart"),
+	DEF_CLKLOOK(&clk_spi, "nuc932-spi", NULL),
+	DEF_CLKLOOK(&clk_pwm, "nuc932-pwm", NULL),
+	DEF_CLKLOOK(&clk_timer, NULL, "timer"),
+	DEF_CLKLOOK(&clk_wdt, "nuc932-wdt", NULL),
+	DEF_CLKLOOK(&clk_ac97, "nuc932-ac97", NULL),
+	DEF_CLKLOOK(&clk_i2s, "nuc932-i2s", NULL),
+	DEF_CLKLOOK(&clk_usbck, "nuc932-usbck", NULL),
+	DEF_CLKLOOK(&clk_usb48, "nuc932-usb48", NULL),
+	DEF_CLKLOOK(&clk_usbh, "nuc932-usbh", NULL),
+	DEF_CLKLOOK(&clk_i2c, "nuc932-i2c", NULL),
+	DEF_CLKLOOK(&clk_ext, NULL, "ext"),
 };
 
 /* define specific CPU platform io map */
-- 
1.5.6.3
