From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 14:45:17 +0800
Subject: [PATCH v2 04/34] ARM: imx: move platform device code into mach-imx
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1348123547-31082-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It moves platform device code from plat-mxc into mach-imx.  Along with
that, header devices-common.h gets moved from plat-mxc/include/mach/
into mach-imx/devices/.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig                          |    2 ++
 arch/arm/mach-imx/Makefile                         |    2 ++
 arch/arm/mach-imx/devices-imx1.h                   |    2 +-
 arch/arm/mach-imx/devices-imx21.h                  |    2 +-
 arch/arm/mach-imx/devices-imx25.h                  |    2 +-
 arch/arm/mach-imx/devices-imx27.h                  |    2 +-
 arch/arm/mach-imx/devices-imx31.h                  |    2 +-
 arch/arm/mach-imx/devices-imx35.h                  |    2 +-
 arch/arm/mach-imx/devices-imx50.h                  |    2 +-
 arch/arm/mach-imx/devices-imx51.h                  |    2 +-
 arch/arm/{plat-mxc => mach-imx}/devices/Kconfig    |    0
 arch/arm/{plat-mxc => mach-imx}/devices/Makefile   |    2 ++
 .../mach => mach-imx/devices}/devices-common.h     |    0
 arch/arm/{plat-mxc => mach-imx/devices}/devices.c  |    0
 .../devices/platform-ahci-imx.c                    |    2 +-
 .../{plat-mxc => mach-imx}/devices/platform-fec.c  |    2 +-
 .../devices/platform-flexcan.c                     |    2 +-
 .../devices/platform-fsl-usb2-udc.c                |    2 +-
 .../devices/platform-gpio-mxc.c                    |    2 +-
 .../devices/platform-gpio_keys.c                   |    2 +-
 .../devices/platform-imx-dma.c                     |    2 +-
 .../devices/platform-imx-fb.c                      |    2 +-
 .../devices/platform-imx-i2c.c                     |    2 +-
 .../devices/platform-imx-keypad.c                  |    2 +-
 .../devices/platform-imx-ssi.c                     |    2 +-
 .../devices/platform-imx-uart.c                    |    2 +-
 .../devices/platform-imx2-wdt.c                    |    2 +-
 .../devices/platform-imx21-hcd.c                   |    2 +-
 .../devices/platform-imx_udc.c                     |    2 +-
 .../devices/platform-imxdi_rtc.c                   |    2 +-
 .../devices/platform-ipu-core.c                    |    2 +-
 .../devices/platform-mx1-camera.c                  |    2 +-
 .../devices/platform-mx2-camera.c                  |    2 +-
 .../devices/platform-mxc-ehci.c                    |    2 +-
 .../devices/platform-mxc-mmc.c                     |    2 +-
 .../devices/platform-mxc_nand.c                    |    2 +-
 .../devices/platform-mxc_pwm.c                     |    2 +-
 .../devices/platform-mxc_rnga.c                    |    2 +-
 .../devices/platform-mxc_rtc.c                     |    2 +-
 .../devices/platform-mxc_w1.c                      |    2 +-
 .../devices/platform-pata_imx.c                    |    2 +-
 .../devices/platform-sdhci-esdhc-imx.c             |    2 +-
 .../devices/platform-spi_imx.c                     |    2 +-
 arch/arm/mach-imx/mm-imx21.c                       |    2 +-
 arch/arm/mach-imx/mm-imx25.c                       |    2 +-
 arch/arm/mach-imx/mm-imx27.c                       |    2 +-
 arch/arm/mach-imx/mm-imx3.c                        |    2 +-
 arch/arm/mach-imx/mm-imx5.c                        |    2 +-
 arch/arm/mach-imx/pm-imx3.c                        |    2 +-
 arch/arm/plat-mxc/Kconfig                          |    2 --
 arch/arm/plat-mxc/Makefile                         |    4 +---
 51 files changed, 50 insertions(+), 48 deletions(-)
 rename arch/arm/{plat-mxc => mach-imx}/devices/Kconfig (100%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/Makefile (98%)
 rename arch/arm/{plat-mxc/include/mach => mach-imx/devices}/devices-common.h (100%)
 rename arch/arm/{plat-mxc => mach-imx/devices}/devices.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-ahci-imx.c (99%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-fec.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-flexcan.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-fsl-usb2-udc.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-gpio-mxc.c (96%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-gpio_keys.c (96%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-imx-dma.c (96%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-imx-fb.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-imx-i2c.c (99%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-imx-keypad.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-imx-ssi.c (99%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-imx-uart.c (99%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-imx2-wdt.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-imx21-hcd.c (97%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-imx_udc.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-imxdi_rtc.c (96%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-ipu-core.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mx1-camera.c (97%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mx2-camera.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mxc-ehci.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mxc-mmc.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mxc_nand.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mxc_pwm.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mxc_rnga.c (97%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mxc_rtc.c (97%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mxc_w1.c (97%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-pata_imx.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-sdhci-esdhc-imx.c (98%)
 rename arch/arm/{plat-mxc => mach-imx}/devices/platform-spi_imx.c (99%)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index d34c026..8e1d4b8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -771,3 +771,5 @@ config SOC_IMX6Q
 	  This enables support for Freescale i.MX6 Quad processor.
 
 endif
+
+source "arch/arm/mach-imx/devices/Kconfig"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 5025a9d..257893e 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -92,3 +92,5 @@ obj-$(CONFIG_MACH_MX50_RDP) += mach-mx50_rdp.o
 
 obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
+
+obj-y += devices/
diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
index eb2603b..f9b5afc 100644
--- a/arch/arm/mach-imx/devices-imx1.h
+++ b/arch/arm/mach-imx/devices-imx1.h
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/devices-common.h>
+#include "devices/devices-common.h"
 
 extern const struct imx_imx_fb_data imx1_imx_fb_data;
 #define imx1_add_imx_fb(pdata) \
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index e2014da..bd93932 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/devices-common.h>
+#include "devices/devices-common.h"
 
 extern const struct imx_imx21_hcd_data imx21_imx21_hcd_data;
 #define imx21_add_imx21_hcd(pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx25.h b/arch/arm/mach-imx/devices-imx25.h
index 29e9706..0d2922b 100644
--- a/arch/arm/mach-imx/devices-imx25.h
+++ b/arch/arm/mach-imx/devices-imx25.h
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/devices-common.h>
+#include "devices/devices-common.h"
 
 extern const struct imx_fec_data imx25_fec_data;
 #define imx25_add_fec(pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 1c85b57..7d41e28 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/devices-common.h>
+#include "devices/devices-common.h"
 
 extern const struct imx_fec_data imx27_fec_data;
 #define imx27_add_fec(pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx31.h b/arch/arm/mach-imx/devices-imx31.h
index 20565f9..e8d1611 100644
--- a/arch/arm/mach-imx/devices-imx31.h
+++ b/arch/arm/mach-imx/devices-imx31.h
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/devices-common.h>
+#include "devices/devices-common.h"
 
 extern const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data;
 #define imx31_add_fsl_usb2_udc(pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx35.h b/arch/arm/mach-imx/devices-imx35.h
index e45b5cb..e2675f1 100644
--- a/arch/arm/mach-imx/devices-imx35.h
+++ b/arch/arm/mach-imx/devices-imx35.h
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/devices-common.h>
+#include "devices/devices-common.h"
 
 extern const struct imx_fec_data imx35_fec_data;
 #define imx35_add_fec(pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx50.h b/arch/arm/mach-imx/devices-imx50.h
index 1615a6a..2c29039 100644
--- a/arch/arm/mach-imx/devices-imx50.h
+++ b/arch/arm/mach-imx/devices-imx50.h
@@ -18,7 +18,7 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#include <mach/devices-common.h>
+#include "devices/devices-common.h"
 
 extern const struct imx_imx_uart_1irq_data imx50_imx_uart_data[];
 #define imx50_add_imx_uart(id, pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx51.h b/arch/arm/mach-imx/devices-imx51.h
index f448104..deee5ba 100644
--- a/arch/arm/mach-imx/devices-imx51.h
+++ b/arch/arm/mach-imx/devices-imx51.h
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/devices-common.h>
+#include "devices/devices-common.h"
 
 extern const struct imx_fec_data imx51_fec_data;
 #define imx51_add_fec(pdata)	\
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/mach-imx/devices/Kconfig
similarity index 100%
rename from arch/arm/plat-mxc/devices/Kconfig
rename to arch/arm/mach-imx/devices/Kconfig
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/mach-imx/devices/Makefile
similarity index 98%
rename from arch/arm/plat-mxc/devices/Makefile
rename to arch/arm/mach-imx/devices/Makefile
index c11ac84..ff22ed1 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/mach-imx/devices/Makefile
@@ -1,3 +1,5 @@
+obj-y := devices.o
+
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC) += platform-fsl-usb2-udc.o
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/devices-common.h
rename to arch/arm/mach-imx/devices/devices-common.h
diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/mach-imx/devices/devices.c
similarity index 100%
rename from arch/arm/plat-mxc/devices.c
rename to arch/arm/mach-imx/devices/devices.c
diff --git a/arch/arm/plat-mxc/devices/platform-ahci-imx.c b/arch/arm/mach-imx/devices/platform-ahci-imx.c
similarity index 99%
rename from arch/arm/plat-mxc/devices/platform-ahci-imx.c
rename to arch/arm/mach-imx/devices/platform-ahci-imx.c
index ade4a1c..bf7f46d 100644
--- a/arch/arm/plat-mxc/devices/platform-ahci-imx.c
+++ b/arch/arm/mach-imx/devices/platform-ahci-imx.c
@@ -25,7 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <asm/sizes.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_ahci_imx_data_entry_single(soc, _devid)		\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/mach-imx/devices/platform-fec.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-fec.c
rename to arch/arm/mach-imx/devices/platform-fec.c
index 0bae44e..e62114f 100644
--- a/arch/arm/plat-mxc/devices/platform-fec.c
+++ b/arch/arm/mach-imx/devices/platform-fec.c
@@ -9,7 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <asm/sizes.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_fec_data_entry_single(soc, _devid)				\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-flexcan.c b/arch/arm/mach-imx/devices/platform-flexcan.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-flexcan.c
rename to arch/arm/mach-imx/devices/platform-flexcan.c
index 4e8497a..e776d8e 100644
--- a/arch/arm/plat-mxc/devices/platform-flexcan.c
+++ b/arch/arm/mach-imx/devices/platform-flexcan.c
@@ -6,7 +6,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_flexcan_data_entry_single(soc, _id, _hwid, _size)		\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
rename to arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
index 848038f..6ecccf9 100644
--- a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
+++ b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
@@ -8,7 +8,7 @@
  */
 #include <linux/dma-mapping.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_fsl_usb2_udc_data_entry_single(soc)				\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-gpio-mxc.c b/arch/arm/mach-imx/devices/platform-gpio-mxc.c
similarity index 96%
rename from arch/arm/plat-mxc/devices/platform-gpio-mxc.c
rename to arch/arm/mach-imx/devices/platform-gpio-mxc.c
index a7919a2..26483fa 100644
--- a/arch/arm/plat-mxc/devices/platform-gpio-mxc.c
+++ b/arch/arm/mach-imx/devices/platform-gpio-mxc.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 struct platform_device *__init mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high)
diff --git a/arch/arm/plat-mxc/devices/platform-gpio_keys.c b/arch/arm/mach-imx/devices/platform-gpio_keys.c
similarity index 96%
rename from arch/arm/plat-mxc/devices/platform-gpio_keys.c
rename to arch/arm/mach-imx/devices/platform-gpio_keys.c
index 1c53a53..3f87279 100644
--- a/arch/arm/plat-mxc/devices/platform-gpio_keys.c
+++ b/arch/arm/mach-imx/devices/platform-gpio_keys.c
@@ -17,7 +17,7 @@
  */
 #include <asm/sizes.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 struct platform_device *__init imx_add_gpio_keys(
 		const struct gpio_keys_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/mach-imx/devices/platform-imx-dma.c
similarity index 96%
rename from arch/arm/plat-mxc/devices/platform-imx-dma.c
rename to arch/arm/mach-imx/devices/platform-imx-dma.c
index 7fa7e9c..c35c99d 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/mach-imx/devices/platform-imx-dma.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 struct platform_device __init __maybe_unused *imx_add_imx_dma(void)
 {
diff --git a/arch/arm/plat-mxc/devices/platform-imx-fb.c b/arch/arm/mach-imx/devices/platform-imx-fb.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-imx-fb.c
rename to arch/arm/mach-imx/devices/platform-imx-fb.c
index 2b0b5e0..4e6f857 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-fb.c
+++ b/arch/arm/mach-imx/devices/platform-imx-fb.c
@@ -8,7 +8,7 @@
  */
 #include <linux/dma-mapping.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_imx_fb_data_entry_single(soc, _size)			\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/mach-imx/devices/platform-imx-i2c.c
similarity index 99%
rename from arch/arm/plat-mxc/devices/platform-imx-i2c.c
rename to arch/arm/mach-imx/devices/platform-imx-i2c.c
index 19ad580..e0c7d62 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
+++ b/arch/arm/mach-imx/devices/platform-imx-i2c.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_imx_i2c_data_entry_single(soc, _id, _hwid, _size)		\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-imx-keypad.c b/arch/arm/mach-imx/devices/platform-imx-keypad.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-imx-keypad.c
rename to arch/arm/mach-imx/devices/platform-imx-keypad.c
index 479c3e9..371b1e6 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-keypad.c
+++ b/arch/arm/mach-imx/devices/platform-imx-keypad.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_imx_keypad_data_entry_single(soc, _size)			\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-imx-ssi.c b/arch/arm/mach-imx/devices/platform-imx-ssi.c
similarity index 99%
rename from arch/arm/plat-mxc/devices/platform-imx-ssi.c
rename to arch/arm/mach-imx/devices/platform-imx-ssi.c
index 21c6f30..bf0c5e4 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-ssi.c
+++ b/arch/arm/mach-imx/devices/platform-imx-ssi.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_imx_ssi_data_entry(soc, _id, _hwid, _size)			\
 	[_id] = {							\
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/mach-imx/devices/platform-imx-uart.c
similarity index 99%
rename from arch/arm/plat-mxc/devices/platform-imx-uart.c
rename to arch/arm/mach-imx/devices/platform-imx-uart.c
index d390f00..e6132f2 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
+++ b/arch/arm/mach-imx/devices/platform-imx-uart.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_imx_uart_3irq_data_entry(soc, _id, _hwid, _size)		\
 	[_id] = {							\
diff --git a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-imx2-wdt.c
rename to arch/arm/mach-imx/devices/platform-imx2-wdt.c
index 5e07ef2..729c191 100644
--- a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
+++ b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
@@ -8,7 +8,7 @@
  */
 #include <asm/sizes.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_imx2_wdt_data_entry_single(soc, _id, _hwid, _size)		\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-imx21-hcd.c b/arch/arm/mach-imx/devices/platform-imx21-hcd.c
similarity index 97%
rename from arch/arm/plat-mxc/devices/platform-imx21-hcd.c
rename to arch/arm/mach-imx/devices/platform-imx21-hcd.c
index 5770a42..18b9963 100644
--- a/arch/arm/plat-mxc/devices/platform-imx21-hcd.c
+++ b/arch/arm/mach-imx/devices/platform-imx21-hcd.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_imx21_hcd_data_entry_single(soc)				\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-imx_udc.c b/arch/arm/mach-imx/devices/platform-imx_udc.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-imx_udc.c
rename to arch/arm/mach-imx/devices/platform-imx_udc.c
index 6fd675d..75aee0b 100644
--- a/arch/arm/plat-mxc/devices/platform-imx_udc.c
+++ b/arch/arm/mach-imx/devices/platform-imx_udc.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_imx_udc_data_entry_single(soc, _size)			\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c b/arch/arm/mach-imx/devices/platform-imxdi_rtc.c
similarity index 96%
rename from arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
rename to arch/arm/mach-imx/devices/platform-imxdi_rtc.c
index 805336f..e4b22eb 100644
--- a/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
+++ b/arch/arm/mach-imx/devices/platform-imxdi_rtc.c
@@ -8,7 +8,7 @@
  */
 #include <asm/sizes.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_imxdi_rtc_data_entry_single(soc)				\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-ipu-core.c b/arch/arm/mach-imx/devices/platform-ipu-core.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-ipu-core.c
rename to arch/arm/mach-imx/devices/platform-ipu-core.c
index d1e33cc..dc0e837 100644
--- a/arch/arm/plat-mxc/devices/platform-ipu-core.c
+++ b/arch/arm/mach-imx/devices/platform-ipu-core.c
@@ -8,7 +8,7 @@
  */
 #include <linux/dma-mapping.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_ipu_core_entry_single(soc)					\
 {									\
diff --git a/arch/arm/plat-mxc/devices/platform-mx1-camera.c b/arch/arm/mach-imx/devices/platform-mx1-camera.c
similarity index 97%
rename from arch/arm/plat-mxc/devices/platform-mx1-camera.c
rename to arch/arm/mach-imx/devices/platform-mx1-camera.c
index edcc581..756b0e6 100644
--- a/arch/arm/plat-mxc/devices/platform-mx1-camera.c
+++ b/arch/arm/mach-imx/devices/platform-mx1-camera.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_mx1_camera_data_entry_single(soc, _size)			\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-mx2-camera.c b/arch/arm/mach-imx/devices/platform-mx2-camera.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-mx2-camera.c
rename to arch/arm/mach-imx/devices/platform-mx2-camera.c
index 11eace9..9ad5b2d 100644
--- a/arch/arm/plat-mxc/devices/platform-mx2-camera.c
+++ b/arch/arm/mach-imx/devices/platform-mx2-camera.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_mx2_camera_data_entry_single(soc)				\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c b/arch/arm/mach-imx/devices/platform-mxc-ehci.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-mxc-ehci.c
rename to arch/arm/mach-imx/devices/platform-mxc-ehci.c
index 35851d8..27c8171 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
+++ b/arch/arm/mach-imx/devices/platform-mxc-ehci.c
@@ -8,7 +8,7 @@
  */
 #include <linux/dma-mapping.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_mxc_ehci_data_entry_single(soc, _id, hs)			\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-mxc-mmc.c b/arch/arm/mach-imx/devices/platform-mxc-mmc.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-mxc-mmc.c
rename to arch/arm/mach-imx/devices/platform-mxc-mmc.c
index 540d3a7..ce90ab0 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
+++ b/arch/arm/mach-imx/devices/platform-mxc-mmc.c
@@ -8,7 +8,7 @@
  */
 #include <linux/dma-mapping.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_mxc_mmc_data_entry_single(soc, _id, _hwid, _size)		\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/mach-imx/devices/platform-mxc_nand.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-mxc_nand.c
rename to arch/arm/mach-imx/devices/platform-mxc_nand.c
index 1568f39..eb73b82 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_nand.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_nand.c
@@ -8,7 +8,7 @@
  */
 #include <asm/sizes.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_mxc_nand_data_entry_single(soc, _size)			\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/mach-imx/devices/platform-mxc_pwm.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-mxc_pwm.c
rename to arch/arm/mach-imx/devices/platform-mxc_pwm.c
index b0c4ae2..a0551bf 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_pwm.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_mxc_pwm_data_entry_single(soc, _id, _hwid, _size)		\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_rnga.c b/arch/arm/mach-imx/devices/platform-mxc_rnga.c
similarity index 97%
rename from arch/arm/plat-mxc/devices/platform-mxc_rnga.c
rename to arch/arm/mach-imx/devices/platform-mxc_rnga.c
index b4b7612..37bb23c 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_rnga.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_rnga.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 struct imx_mxc_rnga_data {
 	resource_size_t iobase;
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_rtc.c b/arch/arm/mach-imx/devices/platform-mxc_rtc.c
similarity index 97%
rename from arch/arm/plat-mxc/devices/platform-mxc_rtc.c
rename to arch/arm/mach-imx/devices/platform-mxc_rtc.c
index a5c9ad5..daaf979 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_rtc.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_rtc.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_mxc_rtc_data_entry_single(soc)				\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_w1.c b/arch/arm/mach-imx/devices/platform-mxc_w1.c
similarity index 97%
rename from arch/arm/plat-mxc/devices/platform-mxc_w1.c
rename to arch/arm/mach-imx/devices/platform-mxc_w1.c
index 96fa5ea..5f972c6 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_w1.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_w1.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_mxc_w1_data_entry_single(soc)				\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-pata_imx.c b/arch/arm/mach-imx/devices/platform-pata_imx.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-pata_imx.c
rename to arch/arm/mach-imx/devices/platform-pata_imx.c
index 70e2f2a..3627ec8d 100644
--- a/arch/arm/plat-mxc/devices/platform-pata_imx.c
+++ b/arch/arm/mach-imx/devices/platform-pata_imx.c
@@ -4,7 +4,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_pata_imx_data_entry_single(soc, _size)			\
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c b/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
similarity index 98%
rename from arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
rename to arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
index 3793e47..772ba2d 100644
--- a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
+++ b/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
@@ -7,8 +7,8 @@
  */
 
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
 #include <linux/platform_data/mmc-esdhc-imx.h>
+#include "devices-common.h"
 
 #define imx_sdhci_esdhc_imx_data_entry_single(soc, _devid, _id, hwid) \
 	{								\
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/mach-imx/devices/platform-spi_imx.c
similarity index 99%
rename from arch/arm/plat-mxc/devices/platform-spi_imx.c
rename to arch/arm/mach-imx/devices/platform-spi_imx.c
index 9c50c14..63a116b 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/mach-imx/devices/platform-spi_imx.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
+#include "devices-common.h"
 
 #define imx_spi_imx_data_entry_single(soc, type, _devid, _id, hwid, _size) \
 	{								\
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 5fda681..79d94aa 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -23,10 +23,10 @@
 #include <linux/pinctrl/machine.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/devices-common.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
 
+#include "devices/devices-common.h"
 #include "iomux-v1.h"
 
 /* MX21 memory map definition */
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index 47bde02..c8ea3aa 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -25,10 +25,10 @@
 #include <asm/mach/map.h>
 
 #include <mach/common.h>
-#include <mach/devices-common.h>
 #include <mach/hardware.h>
 #include <mach/mx25.h>
 
+#include "devices/devices-common.h"
 #include "iomux-v3.h"
 
 /*
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 8d8133e..6d91808 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -23,10 +23,10 @@
 #include <linux/pinctrl/machine.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/devices-common.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
 
+#include "devices/devices-common.h"
 #include "iomux-v1.h"
 
 /* MX27 memory map definition */
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 87fb8644..6a5d4e4 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -27,10 +27,10 @@
 #include <asm/mach/map.h>
 
 #include <mach/common.h>
-#include <mach/devices-common.h>
 #include <mach/hardware.h>
 
 #include "crmregs-imx3.h"
+#include "devices/devices-common.h"
 #include "iomux-v3.h"
 
 void __iomem *mx3_ccm_base;
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index b721b79..cc1423c 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -20,8 +20,8 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/devices-common.h>
 
+#include "devices/devices-common.h"
 #include "iomux-v3.h"
 
 /*
diff --git a/arch/arm/mach-imx/pm-imx3.c b/arch/arm/mach-imx/pm-imx3.c
index 822103b..884dc94 100644
--- a/arch/arm/mach-imx/pm-imx3.c
+++ b/arch/arm/mach-imx/pm-imx3.c
@@ -11,8 +11,8 @@
 #include <linux/io.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/devices-common.h>
 #include "crmregs-imx3.h"
+#include "devices/devices-common.h"
 
 /*
  * Set cpu low power mode before WFI instruction. This function is called
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 2450a98..9ecaf06 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -1,7 +1,5 @@
 if ARCH_MXC
 
-source "arch/arm/plat-mxc/devices/Kconfig"
-
 menu "Freescale MXC Implementations"
 
 choice
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 7cc047c..e33d2d1 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := time.o devices.o cpu.o system.o irq-common.o
+obj-y := time.o cpu.o system.o irq-common.o
 
 obj-$(CONFIG_MXC_TZIC) += tzic.o
 obj-$(CONFIG_MXC_AVIC) += avic.o
@@ -18,5 +18,3 @@ ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
 endif
-
-obj-y += devices/
-- 
1.7.9.5
