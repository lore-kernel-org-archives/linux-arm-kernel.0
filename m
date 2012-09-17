From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 13:35:01 +0800
Subject: [PATCH 32/34] ARM: imx: include hardware.h rather than mach/hardware.h
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347860103-4141-33-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It moves a bunch of header files included in hardware.h and itself
from mach-imx/include/mach to mach-imx, and updates users to include
hardware.h rather than mach/hardware.h.  The files in mach-imx/devices
will need to include "../hardware.h".

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/3ds_debugboard.c                 |    2 +-
 arch/arm/mach-imx/avic.c                           |    2 +-
 arch/arm/mach-imx/clk-imx1.c                       |    3 +--
 arch/arm/mach-imx/clk-imx21.c                      |    3 +--
 arch/arm/mach-imx/clk-imx25.c                      |    5 ++--
 arch/arm/mach-imx/clk-imx27.c                      |    3 +--
 arch/arm/mach-imx/clk-imx31.c                      |    5 ++--
 arch/arm/mach-imx/clk-imx35.c                      |    3 +--
 arch/arm/mach-imx/clk-imx51-imx53.c                |    3 +--
 arch/arm/mach-imx/clk-pllv1.c                      |    2 +-
 arch/arm/mach-imx/cpu-imx25.c                      |    2 +-
 arch/arm/mach-imx/cpu-imx27.c                      |    2 +-
 arch/arm/mach-imx/cpu-imx31.c                      |    2 +-
 arch/arm/mach-imx/cpu-imx35.c                      |    2 +-
 arch/arm/mach-imx/cpu-imx5.c                       |    3 ++-
 arch/arm/mach-imx/cpu.c                            |    3 ++-
 arch/arm/mach-imx/cpu_op-mx51.c                    |    3 ++-
 arch/arm/mach-imx/cpufreq.c                        |    3 ++-
 arch/arm/mach-imx/devices/platform-ahci-imx.c      |    3 ++-
 arch/arm/mach-imx/devices/platform-fec.c           |    3 ++-
 arch/arm/mach-imx/devices/platform-flexcan.c       |    2 +-
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c  |    3 ++-
 arch/arm/mach-imx/devices/platform-gpio_keys.c     |    3 ++-
 arch/arm/mach-imx/devices/platform-imx-fb.c        |    3 ++-
 arch/arm/mach-imx/devices/platform-imx-i2c.c       |    2 +-
 arch/arm/mach-imx/devices/platform-imx-keypad.c    |    2 +-
 arch/arm/mach-imx/devices/platform-imx-ssi.c       |    2 +-
 arch/arm/mach-imx/devices/platform-imx-uart.c      |    2 +-
 arch/arm/mach-imx/devices/platform-imx2-wdt.c      |    3 ++-
 arch/arm/mach-imx/devices/platform-imx21-hcd.c     |    2 +-
 arch/arm/mach-imx/devices/platform-imx_udc.c       |    2 +-
 arch/arm/mach-imx/devices/platform-imxdi_rtc.c     |    3 ++-
 arch/arm/mach-imx/devices/platform-ipu-core.c      |    3 ++-
 arch/arm/mach-imx/devices/platform-mx2-camera.c    |    2 +-
 arch/arm/mach-imx/devices/platform-mxc-ehci.c      |    3 ++-
 arch/arm/mach-imx/devices/platform-mxc-mmc.c       |    3 ++-
 arch/arm/mach-imx/devices/platform-mxc_nand.c      |    3 ++-
 arch/arm/mach-imx/devices/platform-mxc_pwm.c       |    2 +-
 arch/arm/mach-imx/devices/platform-mxc_rnga.c      |    2 +-
 arch/arm/mach-imx/devices/platform-mxc_rtc.c       |    2 +-
 arch/arm/mach-imx/devices/platform-mxc_w1.c        |    2 +-
 arch/arm/mach-imx/devices/platform-pata_imx.c      |    2 +-
 .../mach-imx/devices/platform-sdhci-esdhc-imx.c    |    3 ++-
 arch/arm/mach-imx/devices/platform-spi_imx.c       |    2 +-
 arch/arm/mach-imx/ehci-imx25.c                     |    4 +--
 arch/arm/mach-imx/ehci-imx27.c                     |    4 +--
 arch/arm/mach-imx/ehci-imx31.c                     |    4 +--
 arch/arm/mach-imx/ehci-imx35.c                     |    4 +--
 arch/arm/mach-imx/ehci-imx5.c                      |    4 +--
 arch/arm/mach-imx/epit.c                           |    3 +--
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |    3 +--
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    4 +--
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    3 +--
 arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c     |    3 +--
 arch/arm/mach-imx/{include/mach => }/hardware.h    |   26 ++++++++++----------
 arch/arm/mach-imx/imx27-dt.c                       |    2 +-
 arch/arm/mach-imx/imx31-dt.c                       |    2 +-
 arch/arm/mach-imx/imx51-dt.c                       |    2 +-
 arch/arm/mach-imx/iomux-imx31.c                    |    2 +-
 arch/arm/mach-imx/iomux-v1.c                       |    2 +-
 arch/arm/mach-imx/iomux-v3.c                       |    2 +-
 arch/arm/mach-imx/lluart.c                         |    3 ++-
 arch/arm/mach-imx/mach-apf9328.c                   |    3 +--
 arch/arm/mach-imx/mach-armadillo5x0.c              |    2 +-
 arch/arm/mach-imx/mach-bug.c                       |    3 +--
 arch/arm/mach-imx/mach-cpuimx27.c                  |    3 +--
 arch/arm/mach-imx/mach-cpuimx35.c                  |    3 +--
 arch/arm/mach-imx/mach-cpuimx51sd.c                |    3 +--
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |    4 +--
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |    2 +-
 arch/arm/mach-imx/mach-imx27ipcam.c                |    2 +-
 arch/arm/mach-imx/mach-imx27lite.c                 |    2 +-
 arch/arm/mach-imx/mach-imx53.c                     |    2 +-
 arch/arm/mach-imx/mach-imx6q.c                     |    2 +-
 arch/arm/mach-imx/mach-kzm_arm11_01.c              |    3 +--
 arch/arm/mach-imx/mach-mx1ads.c                    |    3 +--
 arch/arm/mach-imx/mach-mx21ads.c                   |    2 +-
 arch/arm/mach-imx/mach-mx25_3ds.c                  |    4 +--
 arch/arm/mach-imx/mach-mx27_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx27ads.c                   |    2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx31ads.c                   |    2 +-
 arch/arm/mach-imx/mach-mx31lilly.c                 |    3 +--
 arch/arm/mach-imx/mach-mx31lite.c                  |    3 +--
 arch/arm/mach-imx/mach-mx31moboard.c               |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-mx50_rdp.c                  |    3 +--
 arch/arm/mach-imx/mach-mx51_3ds.c                  |    3 +--
 arch/arm/mach-imx/mach-mx51_babbage.c              |    3 +--
 arch/arm/mach-imx/mach-mxt_td60.c                  |    2 +-
 arch/arm/mach-imx/mach-pca100.c                    |    2 +-
 arch/arm/mach-imx/mach-pcm037.c                    |    2 +-
 arch/arm/mach-imx/mach-pcm038.c                    |    3 +--
 arch/arm/mach-imx/mach-pcm043.c                    |    3 +--
 arch/arm/mach-imx/mach-qong.c                      |    2 +-
 arch/arm/mach-imx/mach-scb9328.c                   |    3 +--
 arch/arm/mach-imx/mach-vpr200.c                    |    3 +--
 arch/arm/mach-imx/mm-imx1.c                        |    3 +--
 arch/arm/mach-imx/mm-imx21.c                       |    2 +-
 arch/arm/mach-imx/mm-imx25.c                       |    5 ++--
 arch/arm/mach-imx/mm-imx27.c                       |    2 +-
 arch/arm/mach-imx/mm-imx3.c                        |    3 +--
 arch/arm/mach-imx/mm-imx5.c                        |    3 +--
 arch/arm/mach-imx/{include/mach => }/mx1.h         |    0
 arch/arm/mach-imx/{include/mach => }/mx21.h        |    0
 arch/arm/mach-imx/{include/mach => }/mx25.h        |    0
 arch/arm/mach-imx/{include/mach => }/mx27.h        |    0
 arch/arm/mach-imx/{include/mach => }/mx2x.h        |    0
 arch/arm/mach-imx/{include/mach => }/mx31.h        |    0
 arch/arm/mach-imx/mx31lilly-db.c                   |    3 +--
 arch/arm/mach-imx/mx31lite-db.c                    |    3 +--
 arch/arm/mach-imx/mx31moboard-devboard.c           |    3 +--
 arch/arm/mach-imx/mx31moboard-marxbot.c            |    3 +--
 arch/arm/mach-imx/mx31moboard-smartbot.c           |    3 +--
 arch/arm/mach-imx/{include/mach => }/mx35.h        |    0
 arch/arm/mach-imx/{include/mach => }/mx3x.h        |    0
 arch/arm/mach-imx/{include/mach => }/mx50.h        |    0
 arch/arm/mach-imx/{include/mach => }/mx51.h        |    0
 arch/arm/mach-imx/{include/mach => }/mx53.h        |    0
 arch/arm/mach-imx/{include/mach => }/mx6q.h        |    0
 arch/arm/mach-imx/{include/mach => }/mxc.h         |    0
 arch/arm/mach-imx/pcm970-baseboard.c               |    3 +--
 arch/arm/mach-imx/platsmp.c                        |    2 +-
 arch/arm/mach-imx/pm-imx27.c                       |    3 ++-
 arch/arm/mach-imx/pm-imx3.c                        |    2 +-
 arch/arm/mach-imx/pm-imx5.c                        |    2 +-
 arch/arm/mach-imx/pm-imx6q.c                       |    2 +-
 arch/arm/mach-imx/system.c                         |    2 +-
 arch/arm/mach-imx/time.c                           |    2 +-
 arch/arm/mach-imx/tzic.c                           |    2 +-
 130 files changed, 158 insertions(+), 177 deletions(-)
 rename arch/arm/mach-imx/{include/mach => }/hardware.h (94%)
 rename arch/arm/mach-imx/{include/mach => }/mx1.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx21.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx25.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx27.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx2x.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx31.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx35.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx3x.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx50.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx51.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx53.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mx6q.h (100%)
 rename arch/arm/mach-imx/{include/mach => }/mxc.h (100%)

diff --git a/arch/arm/mach-imx/3ds_debugboard.c b/arch/arm/mach-imx/3ds_debugboard.c
index 5c10ad0..1343773 100644
--- a/arch/arm/mach-imx/3ds_debugboard.c
+++ b/arch/arm/mach-imx/3ds_debugboard.c
@@ -21,7 +21,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 
 /* LAN9217 ethernet base address */
 #define LAN9217_BASE_ADDR(n)	(n + 0x0)
diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 204fd94..adc64bc 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -24,10 +24,10 @@
 #include <linux/of.h>
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 
 #include "common.h"
+#include "hardware.h"
 #include "irq-common.h"
 
 #define AVIC_INTCNTL		0x00	/* int control reg */
diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 4bff66a..7b76bc3 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -22,10 +22,9 @@
 #include <linux/clkdev.h>
 #include <linux/err.h>
 
-#include <mach/hardware.h>
-
 #include "clk.h"
 #include "common.h"
+#include "hardware.h"
 
 /* CCM register addresses */
 #define IO_ADDR_CCM(off)	(MX1_IO_ADDRESS(MX1_CCM_BASE_ADDR + (off)))
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index e981b48..52b0563 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -25,10 +25,9 @@
 #include <linux/module.h>
 #include <linux/err.h>
 
-#include <mach/hardware.h>
-
 #include "clk.h"
 #include "common.h"
+#include "hardware.h"
 
 #define IO_ADDR_CCM(off)	(MX21_IO_ADDRESS(MX21_CCM_BASE_ADDR + (off)))
 
diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index da7155d..d150207 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -24,11 +24,10 @@
 #include <linux/clkdev.h>
 #include <linux/err.h>
 
-#include <mach/hardware.h>
-#include <mach/mx25.h>
-
 #include "clk.h"
 #include "common.h"
+#include "hardware.h"
+#include "mx25.h"
 
 #define CRM_BASE	MX25_IO_ADDRESS(MX25_CRM_BASE_ADDR)
 
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index f3a66a9..e813745 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -6,10 +6,9 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 
-#include <mach/hardware.h>
-
 #include "clk.h"
 #include "common.h"
+#include "hardware.h"
 
 #define IO_ADDR_CCM(off)	(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR + (off)))
 
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 1277f73..8be64e0 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -22,12 +22,11 @@
 #include <linux/err.h>
 #include <linux/of.h>
 
-#include <mach/hardware.h>
-#include <mach/mx31.h>
-
 #include "clk.h"
 #include "common.h"
 #include "crmregs-imx3.h"
+#include "hardware.h"
+#include "mx31.h"
 
 static const char *mcu_main_sel[] = { "spll", "mpll", };
 static const char *per_sel[] = { "per_div", "ipg", };
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index fec48e6..66f3d65 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -14,11 +14,10 @@
 #include <linux/of.h>
 #include <linux/err.h>
 
-#include <mach/hardware.h>
-
 #include "crmregs-imx3.h"
 #include "clk.h"
 #include "common.h"
+#include "hardware.h"
 
 struct arm_ahb_div {
 	unsigned char arm, ahb, sel;
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 22afd5f..e9fd813 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -14,11 +14,10 @@
 #include <linux/of.h>
 #include <linux/err.h>
 
-#include <mach/hardware.h>
-
 #include "crm-regs-imx5.h"
 #include "clk.h"
 #include "common.h"
+#include "hardware.h"
 
 /* Low-power Audio Playback Mode clock */
 static const char *lp_apm_sel[] = { "osc", };
diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
index 02f9013..abff350 100644
--- a/arch/arm/mach-imx/clk-pllv1.c
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -4,10 +4,10 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
-#include <mach/hardware.h>
 
 #include "clk.h"
 #include "common.h"
+#include "hardware.h"
 
 /**
  * pll v1
diff --git a/arch/arm/mach-imx/cpu-imx25.c b/arch/arm/mach-imx/cpu-imx25.c
index 79d4d1c..96ec64b 100644
--- a/arch/arm/mach-imx/cpu-imx25.c
+++ b/arch/arm/mach-imx/cpu-imx25.c
@@ -11,9 +11,9 @@
  */
 #include <linux/module.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
 
 #include "iim.h"
+#include "hardware.h"
 
 static int mx25_cpu_rev = -1;
 
diff --git a/arch/arm/mach-imx/cpu-imx27.c b/arch/arm/mach-imx/cpu-imx27.c
index ff38e15..fe8d36f 100644
--- a/arch/arm/mach-imx/cpu-imx27.c
+++ b/arch/arm/mach-imx/cpu-imx27.c
@@ -24,7 +24,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 
 static int mx27_cpu_rev = -1;
 static int mx27_cpu_partnumber;
diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
index 51c938f..fde1860 100644
--- a/arch/arm/mach-imx/cpu-imx31.c
+++ b/arch/arm/mach-imx/cpu-imx31.c
@@ -11,9 +11,9 @@
 
 #include <linux/module.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
 
 #include "common.h"
+#include "hardware.h"
 #include "iim.h"
 
 static int mx31_cpu_rev = -1;
diff --git a/arch/arm/mach-imx/cpu-imx35.c b/arch/arm/mach-imx/cpu-imx35.c
index 8b36d3a..ec3aaa0 100644
--- a/arch/arm/mach-imx/cpu-imx35.c
+++ b/arch/arm/mach-imx/cpu-imx35.c
@@ -10,8 +10,8 @@
  */
 #include <linux/module.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
 
+#include "hardware.h"
 #include "iim.h"
 
 static int mx35_cpu_rev = -1;
diff --git a/arch/arm/mach-imx/cpu-imx5.c b/arch/arm/mach-imx/cpu-imx5.c
index 8eb15a2..d887600 100644
--- a/arch/arm/mach-imx/cpu-imx5.c
+++ b/arch/arm/mach-imx/cpu-imx5.c
@@ -15,9 +15,10 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <mach/hardware.h>
 #include <linux/io.h>
 
+#include "hardware.h"
+
 static int mx5_cpu_rev = -1;
 
 #define IIM_SREV 0x24
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 220dd6f..03fcbd0 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -1,7 +1,8 @@
 
 #include <linux/module.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
+
+#include "hardware.h"
 
 unsigned int __mxc_cpu_type;
 EXPORT_SYMBOL(__mxc_cpu_type);
diff --git a/arch/arm/mach-imx/cpu_op-mx51.c b/arch/arm/mach-imx/cpu_op-mx51.c
index 7b92cd6..b9ef692 100644
--- a/arch/arm/mach-imx/cpu_op-mx51.c
+++ b/arch/arm/mach-imx/cpu_op-mx51.c
@@ -13,9 +13,10 @@
 
 #include <linux/bug.h>
 #include <linux/types.h>
-#include <mach/hardware.h>
 #include <linux/kernel.h>
 
+#include "hardware.h"
+
 static struct cpu_op mx51_cpu_op[] = {
 	{
 	.cpu_rate = 160000000,},
diff --git a/arch/arm/mach-imx/cpufreq.c b/arch/arm/mach-imx/cpufreq.c
index b5b6f80..36e8b39 100644
--- a/arch/arm/mach-imx/cpufreq.c
+++ b/arch/arm/mach-imx/cpufreq.c
@@ -22,7 +22,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/slab.h>
-#include <mach/hardware.h>
+
+#include "hardware.h"
 
 #define CLK32_FREQ	32768
 #define NANOSECOND	(1000 * 1000 * 1000)
diff --git a/arch/arm/mach-imx/devices/platform-ahci-imx.c b/arch/arm/mach-imx/devices/platform-ahci-imx.c
index bf7f46d..3d87dd9 100644
--- a/arch/arm/mach-imx/devices/platform-ahci-imx.c
+++ b/arch/arm/mach-imx/devices/platform-ahci-imx.c
@@ -24,7 +24,8 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <asm/sizes.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_ahci_imx_data_entry_single(soc, _devid)		\
diff --git a/arch/arm/mach-imx/devices/platform-fec.c b/arch/arm/mach-imx/devices/platform-fec.c
index e62114f..2cb188a 100644
--- a/arch/arm/mach-imx/devices/platform-fec.c
+++ b/arch/arm/mach-imx/devices/platform-fec.c
@@ -8,7 +8,8 @@
  */
 #include <linux/dma-mapping.h>
 #include <asm/sizes.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_fec_data_entry_single(soc, _devid)				\
diff --git a/arch/arm/mach-imx/devices/platform-flexcan.c b/arch/arm/mach-imx/devices/platform-flexcan.c
index e776d8e..1078bf0 100644
--- a/arch/arm/mach-imx/devices/platform-flexcan.c
+++ b/arch/arm/mach-imx/devices/platform-flexcan.c
@@ -5,7 +5,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_flexcan_data_entry_single(soc, _id, _hwid, _size)		\
diff --git a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
index 6ecccf9..37e4439 100644
--- a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
+++ b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include <linux/dma-mapping.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_fsl_usb2_udc_data_entry_single(soc)				\
diff --git a/arch/arm/mach-imx/devices/platform-gpio_keys.c b/arch/arm/mach-imx/devices/platform-gpio_keys.c
index 3f87279..4862825 100644
--- a/arch/arm/mach-imx/devices/platform-gpio_keys.c
+++ b/arch/arm/mach-imx/devices/platform-gpio_keys.c
@@ -16,7 +16,8 @@
  * Boston, MA  02110-1301, USA.
  */
 #include <asm/sizes.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 struct platform_device *__init imx_add_gpio_keys(
diff --git a/arch/arm/mach-imx/devices/platform-imx-fb.c b/arch/arm/mach-imx/devices/platform-imx-fb.c
index abea28b..10b0ed3 100644
--- a/arch/arm/mach-imx/devices/platform-imx-fb.c
+++ b/arch/arm/mach-imx/devices/platform-imx-fb.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include <linux/dma-mapping.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_imx_fb_data_entry_single(soc, _devid, _size)		\
diff --git a/arch/arm/mach-imx/devices/platform-imx-i2c.c b/arch/arm/mach-imx/devices/platform-imx-i2c.c
index 4a701fc..d1cb34a 100644
--- a/arch/arm/mach-imx/devices/platform-imx-i2c.c
+++ b/arch/arm/mach-imx/devices/platform-imx-i2c.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_imx_i2c_data_entry_single(soc, _devid, _id, _hwid, _size)	\
diff --git a/arch/arm/mach-imx/devices/platform-imx-keypad.c b/arch/arm/mach-imx/devices/platform-imx-keypad.c
index 371b1e6..8f22a4c 100644
--- a/arch/arm/mach-imx/devices/platform-imx-keypad.c
+++ b/arch/arm/mach-imx/devices/platform-imx-keypad.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_imx_keypad_data_entry_single(soc, _size)			\
diff --git a/arch/arm/mach-imx/devices/platform-imx-ssi.c b/arch/arm/mach-imx/devices/platform-imx-ssi.c
index bf0c5e4..bfcb8f3 100644
--- a/arch/arm/mach-imx/devices/platform-imx-ssi.c
+++ b/arch/arm/mach-imx/devices/platform-imx-ssi.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_imx_ssi_data_entry(soc, _id, _hwid, _size)			\
diff --git a/arch/arm/mach-imx/devices/platform-imx-uart.c b/arch/arm/mach-imx/devices/platform-imx-uart.c
index e6132f2..67bf866 100644
--- a/arch/arm/mach-imx/devices/platform-imx-uart.c
+++ b/arch/arm/mach-imx/devices/platform-imx-uart.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_imx_uart_3irq_data_entry(soc, _id, _hwid, _size)		\
diff --git a/arch/arm/mach-imx/devices/platform-imx2-wdt.c b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
index 729c191..ec75d64 100644
--- a/arch/arm/mach-imx/devices/platform-imx2-wdt.c
+++ b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include <asm/sizes.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_imx2_wdt_data_entry_single(soc, _id, _hwid, _size)		\
diff --git a/arch/arm/mach-imx/devices/platform-imx21-hcd.c b/arch/arm/mach-imx/devices/platform-imx21-hcd.c
index 18b9963..30c8161 100644
--- a/arch/arm/mach-imx/devices/platform-imx21-hcd.c
+++ b/arch/arm/mach-imx/devices/platform-imx21-hcd.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_imx21_hcd_data_entry_single(soc)				\
diff --git a/arch/arm/mach-imx/devices/platform-imx_udc.c b/arch/arm/mach-imx/devices/platform-imx_udc.c
index 75aee0b..5ced7e4 100644
--- a/arch/arm/mach-imx/devices/platform-imx_udc.c
+++ b/arch/arm/mach-imx/devices/platform-imx_udc.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_imx_udc_data_entry_single(soc, _size)			\
diff --git a/arch/arm/mach-imx/devices/platform-imxdi_rtc.c b/arch/arm/mach-imx/devices/platform-imxdi_rtc.c
index e4b22eb..5bb490d 100644
--- a/arch/arm/mach-imx/devices/platform-imxdi_rtc.c
+++ b/arch/arm/mach-imx/devices/platform-imxdi_rtc.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include <asm/sizes.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_imxdi_rtc_data_entry_single(soc)				\
diff --git a/arch/arm/mach-imx/devices/platform-ipu-core.c b/arch/arm/mach-imx/devices/platform-ipu-core.c
index dc0e837..fc4dd7c 100644
--- a/arch/arm/mach-imx/devices/platform-ipu-core.c
+++ b/arch/arm/mach-imx/devices/platform-ipu-core.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include <linux/dma-mapping.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_ipu_core_entry_single(soc)					\
diff --git a/arch/arm/mach-imx/devices/platform-mx2-camera.c b/arch/arm/mach-imx/devices/platform-mx2-camera.c
index b88877d..f491016 100644
--- a/arch/arm/mach-imx/devices/platform-mx2-camera.c
+++ b/arch/arm/mach-imx/devices/platform-mx2-camera.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_mx2_camera_data_entry_single(soc, _devid)			\
diff --git a/arch/arm/mach-imx/devices/platform-mxc-ehci.c b/arch/arm/mach-imx/devices/platform-mxc-ehci.c
index 27c8171..5d4bbbf 100644
--- a/arch/arm/mach-imx/devices/platform-mxc-ehci.c
+++ b/arch/arm/mach-imx/devices/platform-mxc-ehci.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include <linux/dma-mapping.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_mxc_ehci_data_entry_single(soc, _id, hs)			\
diff --git a/arch/arm/mach-imx/devices/platform-mxc-mmc.c b/arch/arm/mach-imx/devices/platform-mxc-mmc.c
index 487f61c..7da19af 100644
--- a/arch/arm/mach-imx/devices/platform-mxc-mmc.c
+++ b/arch/arm/mach-imx/devices/platform-mxc-mmc.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include <linux/dma-mapping.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_mxc_mmc_data_entry_single(soc, _devid, _id, _hwid, _size)	\
diff --git a/arch/arm/mach-imx/devices/platform-mxc_nand.c b/arch/arm/mach-imx/devices/platform-mxc_nand.c
index cec6961..6743b11 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_nand.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_nand.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include <asm/sizes.h>
-#include <mach/hardware.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_mxc_nand_data_entry_single(soc, _devid, _size)		\
diff --git a/arch/arm/mach-imx/devices/platform-mxc_pwm.c b/arch/arm/mach-imx/devices/platform-mxc_pwm.c
index a0551bf..dcd2897 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_pwm.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_pwm.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_mxc_pwm_data_entry_single(soc, _id, _hwid, _size)		\
diff --git a/arch/arm/mach-imx/devices/platform-mxc_rnga.c b/arch/arm/mach-imx/devices/platform-mxc_rnga.c
index 37bb23c..c58404b 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_rnga.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_rnga.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 struct imx_mxc_rnga_data {
diff --git a/arch/arm/mach-imx/devices/platform-mxc_rtc.c b/arch/arm/mach-imx/devices/platform-mxc_rtc.c
index f35f848..c7fffaa 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_rtc.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_rtc.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_mxc_rtc_data_entry_single(soc, _devid)			\
diff --git a/arch/arm/mach-imx/devices/platform-mxc_w1.c b/arch/arm/mach-imx/devices/platform-mxc_w1.c
index 5f972c6..88c18b7 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_w1.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_w1.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_mxc_w1_data_entry_single(soc)				\
diff --git a/arch/arm/mach-imx/devices/platform-pata_imx.c b/arch/arm/mach-imx/devices/platform-pata_imx.c
index 3627ec8d..e4ec11c 100644
--- a/arch/arm/mach-imx/devices/platform-pata_imx.c
+++ b/arch/arm/mach-imx/devices/platform-pata_imx.c
@@ -3,7 +3,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_pata_imx_data_entry_single(soc, _size)			\
diff --git a/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c b/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
index 772ba2d..e66a4e3 100644
--- a/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
+++ b/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
@@ -6,8 +6,9 @@
  * Free Software Foundation.
  */
 
-#include <mach/hardware.h>
 #include <linux/platform_data/mmc-esdhc-imx.h>
+
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_sdhci_esdhc_imx_data_entry_single(soc, _devid, _id, hwid) \
diff --git a/arch/arm/mach-imx/devices/platform-spi_imx.c b/arch/arm/mach-imx/devices/platform-spi_imx.c
index 63a116b..8880bcb 100644
--- a/arch/arm/mach-imx/devices/platform-spi_imx.c
+++ b/arch/arm/mach-imx/devices/platform-spi_imx.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <mach/hardware.h>
+#include "../hardware.h"
 #include "devices-common.h"
 
 #define imx_spi_imx_data_entry_single(soc, type, _devid, _id, hwid, _size) \
diff --git a/arch/arm/mach-imx/ehci-imx25.c b/arch/arm/mach-imx/ehci-imx25.c
index 412c583..27e40d1 100644
--- a/arch/arm/mach-imx/ehci-imx25.c
+++ b/arch/arm/mach-imx/ehci-imx25.c
@@ -15,10 +15,10 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
-
-#include <mach/hardware.h>
 #include <linux/platform_data/usb-ehci-mxc.h>
 
+#include "hardware.h"
+
 #define USBCTRL_OTGBASE_OFFSET	0x600
 
 #define MX25_OTG_SIC_SHIFT	29
diff --git a/arch/arm/mach-imx/ehci-imx27.c b/arch/arm/mach-imx/ehci-imx27.c
index cd6e1f8..448d911 100644
--- a/arch/arm/mach-imx/ehci-imx27.c
+++ b/arch/arm/mach-imx/ehci-imx27.c
@@ -15,10 +15,10 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
-
-#include <mach/hardware.h>
 #include <linux/platform_data/usb-ehci-mxc.h>
 
+#include "hardware.h"
+
 #define USBCTRL_OTGBASE_OFFSET	0x600
 
 #define MX27_OTG_SIC_SHIFT	29
diff --git a/arch/arm/mach-imx/ehci-imx31.c b/arch/arm/mach-imx/ehci-imx31.c
index 9a880c7..05de4e1 100644
--- a/arch/arm/mach-imx/ehci-imx31.c
+++ b/arch/arm/mach-imx/ehci-imx31.c
@@ -15,10 +15,10 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
-
-#include <mach/hardware.h>
 #include <linux/platform_data/usb-ehci-mxc.h>
 
+#include "hardware.h"
+
 #define USBCTRL_OTGBASE_OFFSET	0x600
 
 #define MX31_OTG_SIC_SHIFT	29
diff --git a/arch/arm/mach-imx/ehci-imx35.c b/arch/arm/mach-imx/ehci-imx35.c
index 779e16e..a596f70 100644
--- a/arch/arm/mach-imx/ehci-imx35.c
+++ b/arch/arm/mach-imx/ehci-imx35.c
@@ -15,10 +15,10 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
-
-#include <mach/hardware.h>
 #include <linux/platform_data/usb-ehci-mxc.h>
 
+#include "hardware.h"
+
 #define USBCTRL_OTGBASE_OFFSET	0x600
 
 #define MX35_OTG_SIC_SHIFT	29
diff --git a/arch/arm/mach-imx/ehci-imx5.c b/arch/arm/mach-imx/ehci-imx5.c
index cf8d00e..e49710b 100644
--- a/arch/arm/mach-imx/ehci-imx5.c
+++ b/arch/arm/mach-imx/ehci-imx5.c
@@ -15,10 +15,10 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
-
-#include <mach/hardware.h>
 #include <linux/platform_data/usb-ehci-mxc.h>
 
+#include "hardware.h"
+
 #define MXC_OTG_OFFSET			0
 #define MXC_H1_OFFSET			0x200
 #define MXC_H2_OFFSET			0x400
diff --git a/arch/arm/mach-imx/epit.c b/arch/arm/mach-imx/epit.c
index 76720f5..04a5961 100644
--- a/arch/arm/mach-imx/epit.c
+++ b/arch/arm/mach-imx/epit.c
@@ -51,11 +51,10 @@
 #include <linux/clockchips.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-
-#include <mach/hardware.h>
 #include <asm/mach/time.h>
 
 #include "common.h"
+#include "hardware.h"
 
 static struct clock_event_device clockevent_epit;
 static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index c29e2c5..b94cf41 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -29,10 +29,9 @@
 
 #include <asm/mach/arch.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx27.h"
+#include "hardware.h"
 #include "iomux-mx27.h"
 
 static const int eukrea_mbimx27_pins[] __initconst = {
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index fd7112e..0c549b7 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -26,14 +26,14 @@
 #include <linux/spi/spi.h>
 #include <video/platform_lcd.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/mx25.h>
 
 #include "common.h"
 #include "devices-imx25.h"
+#include "hardware.h"
 #include "iomux-mx25.h"
+#include "mx25.h"
 
 static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	/* LCD */
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 01b5996..1322d51 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -36,10 +36,9 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx35.h"
+#include "hardware.h"
 #include "iomux-mx35.h"
 
 static const struct fb_videomode fb_modedb[] = {
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
index 17245a4..87807cc 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
@@ -36,10 +36,9 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx51.h"
+#include "hardware.h"
 #include "iomux-mx51.h"
 
 static iomux_v3_cfg_t eukrea_mbimxsd51_pads[] = {
diff --git a/arch/arm/mach-imx/include/mach/hardware.h b/arch/arm/mach-imx/hardware.h
similarity index 94%
rename from arch/arm/mach-imx/include/mach/hardware.h
rename to arch/arm/mach-imx/hardware.h
index ebf1065..3ce7fa3 100644
--- a/arch/arm/mach-imx/include/mach/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -105,20 +105,20 @@
 
 #define IMX_IO_ADDRESS(x)	IOMEM(IMX_IO_P2V(x))
 
-#include <mach/mxc.h>
+#include "mxc.h"
 
-#include <mach/mx6q.h>
-#include <mach/mx50.h>
-#include <mach/mx51.h>
-#include <mach/mx53.h>
-#include <mach/mx3x.h>
-#include <mach/mx31.h>
-#include <mach/mx35.h>
-#include <mach/mx2x.h>
-#include <mach/mx21.h>
-#include <mach/mx27.h>
-#include <mach/mx1.h>
-#include <mach/mx25.h>
+#include "mx6q.h"
+#include "mx50.h"
+#include "mx51.h"
+#include "mx53.h"
+#include "mx3x.h"
+#include "mx31.h"
+#include "mx35.h"
+#include "mx2x.h"
+#include "mx21.h"
+#include "mx27.h"
+#include "mx1.h"
+#include "mx25.h"
 
 #define imx_map_entry(soc, name, _type)	{				\
 	.virtual = soc ## _IO_P2V(soc ## _ ## name ## _BASE_ADDR),	\
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index a6c288e..ebfae96 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -14,9 +14,9 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <mach/mx27.h>
 
 #include "common.h"
+#include "mx27.h"
 
 static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("fsl,imx27-uart", MX27_UART1_BASE_ADDR, "imx21-uart.0", NULL),
diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index 408afcc..af476de 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -14,9 +14,9 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <mach/mx31.h>
 
 #include "common.h"
+#include "mx31.h"
 
 static const struct of_dev_auxdata imx31_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART1_BASE_ADDR,
diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index a0391a1..5074299 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -15,9 +15,9 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <mach/mx51.h>
 
 #include "common.h"
+#include "mx51.h"
 
 /*
  * Lookup table for attaching a specific name and platform_data pointer to
diff --git a/arch/arm/mach-imx/iomux-imx31.c b/arch/arm/mach-imx/iomux-imx31.c
index 7c3ba2b..cabefbc 100644
--- a/arch/arm/mach-imx/iomux-imx31.c
+++ b/arch/arm/mach-imx/iomux-imx31.c
@@ -22,8 +22,8 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <mach/hardware.h>
 
+#include "hardware.h"
 #include "iomux-mx3.h"
 
 /*
diff --git a/arch/arm/mach-imx/iomux-v1.c b/arch/arm/mach-imx/iomux-v1.c
index 2ac5580..2b156d1 100644
--- a/arch/arm/mach-imx/iomux-v1.c
+++ b/arch/arm/mach-imx/iomux-v1.c
@@ -28,9 +28,9 @@
 #include <linux/string.h>
 #include <linux/gpio.h>
 
-#include <mach/hardware.h>
 #include <asm/mach/map.h>
 
+#include "hardware.h"
 #include "iomux-v1.h"
 
 static void __iomem *imx_iomuxv1_baseaddr;
diff --git a/arch/arm/mach-imx/iomux-v3.c b/arch/arm/mach-imx/iomux-v3.c
index de1459c..9dae74b 100644
--- a/arch/arm/mach-imx/iomux-v3.c
+++ b/arch/arm/mach-imx/iomux-v3.c
@@ -25,9 +25,9 @@
 #include <linux/string.h>
 #include <linux/gpio.h>
 
-#include <mach/hardware.h>
 #include <asm/mach/map.h>
 
+#include "hardware.h"
 #include "iomux-v3.h"
 
 static void __iomem *base;
diff --git a/arch/arm/mach-imx/lluart.c b/arch/arm/mach-imx/lluart.c
index c40a34c..5f15103 100644
--- a/arch/arm/mach-imx/lluart.c
+++ b/arch/arm/mach-imx/lluart.c
@@ -14,7 +14,8 @@
 #include <asm/page.h>
 #include <asm/sizes.h>
 #include <asm/mach/map.h>
-#include <mach/hardware.h>
+
+#include "hardware.h"
 
 static struct map_desc imx_lluart_desc = {
 #ifdef CONFIG_DEBUG_IMX6Q_UART2
diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
index a0b4c3f..5c9bd2c 100644
--- a/arch/arm/mach-imx/mach-apf9328.c
+++ b/arch/arm/mach-imx/mach-apf9328.c
@@ -25,10 +25,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx1.h"
+#include "hardware.h"
 #include "iomux-mx1.h"
 
 static const int apf9328_pins[] __initconst = {
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index ea8731f..ae6484a 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -41,7 +41,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -51,6 +50,7 @@
 #include "common.h"
 #include "devices-imx31.h"
 #include "crmregs-imx3.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mach-bug.c b/arch/arm/mach-imx/mach-bug.c
index b98e982..3a39d5a 100644
--- a/arch/arm/mach-imx/mach-bug.c
+++ b/arch/arm/mach-imx/mach-bug.c
@@ -19,14 +19,13 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 
-#include <mach/hardware.h>
-
 #include <asm/mach/time.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 37571f3..12a3706 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -34,11 +34,10 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx27.h"
 #include "eukrea-baseboards.h"
+#include "hardware.h"
 #include "iomux-mx27.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index 86d4ac9..5a31bf8 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -37,11 +37,10 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx35.h"
 #include "eukrea-baseboards.h"
+#include "hardware.h"
 #include "iomux-mx35.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index 58ad093..b727de0 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -26,8 +26,6 @@
 #include <linux/spi/spi.h>
 #include <linux/can/platform/mcp251x.h>
 
-#include <mach/hardware.h>
-
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -37,6 +35,7 @@
 #include "devices-imx51.h"
 #include "cpu_op-mx51.h"
 #include "eukrea-baseboards.h"
+#include "hardware.h"
 #include "iomux-mx51.h"
 
 #define USBH1_RST		IMX_GPIO_NR(2, 28)
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index e754b0c..75027a5 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -27,18 +27,18 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/memory.h>
 #include <asm/mach/map.h>
-#include <mach/mx25.h>
 
 #include "common.h"
 #include "devices-imx25.h"
 #include "eukrea-baseboards.h"
+#include "hardware.h"
 #include "iomux-mx25.h"
+#include "mx25.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 31e30a2..a4dad7c 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -40,10 +40,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/system_info.h>
-#include <mach/hardware.h>
 
 #include "common.h"
 #include "devices-imx27.h"
+#include "hardware.h"
 #include "iomux-mx27.h"
 
 #define TVP5150_RSTN (GPIO_PORTC + 18)
diff --git a/arch/arm/mach-imx/mach-imx27ipcam.c b/arch/arm/mach-imx/mach-imx27ipcam.c
index 725a87f..53a8601 100644
--- a/arch/arm/mach-imx/mach-imx27ipcam.c
+++ b/arch/arm/mach-imx/mach-imx27ipcam.c
@@ -17,8 +17,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <mach/hardware.h>
 
+#include "hardware.h"
 #include "common.h"
 #include "devices-imx27.h"
 #include "iomux-mx27.h"
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index ec46030..fc8dce9 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -20,10 +20,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <mach/hardware.h>
 
 #include "common.h"
 #include "devices-imx27.h"
+#include "hardware.h"
 #include "iomux-mx27.h"
 
 static const int mx27lite_pins[] __initconst = {
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 0e0aadfb..e71e6261 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -19,9 +19,9 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <mach/mx53.h>
 
 #include "common.h"
+#include "mx53.h"
 
 /*
  * Lookup table for attaching a specific name and platform_data pointer to
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index b74f02f..a6f114e 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -32,10 +32,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
-#include <mach/hardware.h>
 
 #include "common.h"
 #include "cpuidle.h"
+#include "hardware.h"
 
 void imx6q_restart(char mode, const char *cmd)
 {
diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index 73334b8..11b198a 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -36,10 +36,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 
 #define KZM_ARM11_IO_ADDRESS(x) (IOMEM(					\
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 8be62f3..06b4837 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -23,10 +23,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx1.h"
+#include "hardware.h"
 #include "iomux-mx1.h"
 
 static const int mx1ads_pins[] __initconst = {
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 99adc9f..6adb313 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -18,7 +18,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/physmap.h>
 #include <linux/gpio.h>
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -26,6 +25,7 @@
 
 #include "common.h"
 #include "devices-imx21.h"
+#include "hardware.h"
 #include "iomux-mx21.h"
 
 /*
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 5a17dd6..b1b03aa 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -31,17 +31,17 @@
 #include <linux/platform_device.h>
 #include <linux/usb/otg.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/memory.h>
 #include <asm/mach/map.h>
-#include <mach/mx25.h>
 
 #include "common.h"
 #include "devices-imx25.h"
+#include "hardware.h"
 #include "iomux-mx25.h"
+#include "mx25.h"
 
 #define MX25PDK_CAN_PWDN	IMX_GPIO_NR(4, 6)
 
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index a54df77..d0e547f 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -36,11 +36,11 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <mach/hardware.h>
 
 #include "3ds_debugboard.h"
 #include "common.h"
 #include "devices-imx27.h"
+#include "hardware.h"
 #include "iomux-mx27.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index beb281c..3d036f5 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -21,7 +21,6 @@
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
 #include <linux/irq.h>
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -29,6 +28,7 @@
 
 #include "common.h"
 #include "devices-imx27.h"
+#include "hardware.h"
 #include "iomux-mx27.h"
 
 /*
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 0333567..bc301be 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -30,7 +30,6 @@
 
 #include <media/soc_camera.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -41,6 +40,7 @@
 #include "3ds_debugboard.h"
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 1fab27a..c5d4be9 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -28,7 +28,6 @@
 #include <asm/mach/time.h>
 #include <asm/memory.h>
 #include <asm/mach/map.h>
-#include <mach/hardware.h>
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
 #include <linux/mfd/wm8350/audio.h>
@@ -38,6 +37,7 @@
 
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 
 /* Base address of PBC controller */
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 74b5fa9..08b9965 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -42,11 +42,10 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "board-mx31lilly.h"
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index 904aa63..8139097 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -39,11 +39,10 @@
 #include <asm/page.h>
 #include <asm/setup.h>
 
-#include <mach/hardware.h>
-
 #include "board-mx31lite.h"
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 31c7d05..2517cfa 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -42,12 +42,12 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
-#include <mach/hardware.h>
 #include <linux/platform_data/asoc-imx-ssi.h>
 
 #include "board-mx31moboard.h"
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index ee7d037..5277da4 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -43,7 +43,6 @@
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
 
-#include <mach/hardware.h>
 #include <video/platform_lcd.h>
 
 #include <media/soc_camera.h>
@@ -51,6 +50,7 @@
 #include "3ds_debugboard.h"
 #include "common.h"
 #include "devices-imx35.h"
+#include "hardware.h"
 #include "iomux-mx35.h"
 
 #define GPIO_MC9S08DZ60_GPS_ENABLE 0
diff --git a/arch/arm/mach-imx/mach-mx50_rdp.c b/arch/arm/mach-imx/mach-mx50_rdp.c
index 4a3e98e..0c1f88a 100644
--- a/arch/arm/mach-imx/mach-mx50_rdp.c
+++ b/arch/arm/mach-imx/mach-mx50_rdp.c
@@ -24,8 +24,6 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-
 #include <asm/irq.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -34,6 +32,7 @@
 
 #include "common.h"
 #include "devices-imx50.h"
+#include "hardware.h"
 #include "iomux-mx50.h"
 
 #define FEC_EN		IMX_GPIO_NR(6, 23)
diff --git a/arch/arm/mach-imx/mach-mx51_3ds.c b/arch/arm/mach-imx/mach-mx51_3ds.c
index 476c759..abc25bd 100644
--- a/arch/arm/mach-imx/mach-mx51_3ds.c
+++ b/arch/arm/mach-imx/mach-mx51_3ds.c
@@ -19,11 +19,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-
 #include "3ds_debugboard.h"
 #include "common.h"
 #include "devices-imx51.h"
+#include "hardware.h"
 #include "iomux-mx51.h"
 
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
diff --git a/arch/arm/mach-imx/mach-mx51_babbage.c b/arch/arm/mach-imx/mach-mx51_babbage.c
index 383948a..d9a84ca 100644
--- a/arch/arm/mach-imx/mach-mx51_babbage.c
+++ b/arch/arm/mach-imx/mach-mx51_babbage.c
@@ -20,8 +20,6 @@
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
 
-#include <mach/hardware.h>
-
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -30,6 +28,7 @@
 #include "common.h"
 #include "devices-imx51.h"
 #include "cpu_op-mx51.h"
+#include "hardware.h"
 #include "iomux-mx51.h"
 
 #define BABBAGE_USB_HUB_RESET	IMX_GPIO_NR(1, 7)
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index f1cbe03..f4a8c7e 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -21,7 +21,6 @@
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
 #include <linux/irq.h>
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -31,6 +30,7 @@
 
 #include "common.h"
 #include "devices-imx27.h"
+#include "hardware.h"
 #include "iomux-mx27.h"
 
 static const int mxt_td60_pins[] __initconst = {
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 743d7e9..eee369f 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -32,11 +32,11 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
-#include <mach/hardware.h>
 #include <asm/mach/time.h>
 
 #include "common.h"
 #include "devices-imx27.h"
+#include "hardware.h"
 #include "iomux-mx27.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 525f057..547fef1 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -42,10 +42,10 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
-#include <mach/hardware.h>
 
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 #include "pcm037.h"
 #include "ulpi.h"
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 8bf95f5..4aa0d07 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -33,11 +33,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-
 #include "board-pcm038.h"
 #include "common.h"
 #include "devices-imx27.h"
+#include "hardware.h"
 #include "iomux-mx27.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 54ac947..9244544 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -33,10 +33,9 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx35.h"
+#include "hardware.h"
 #include "iomux-mx35.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index 962988a..96d9a91 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -21,7 +21,6 @@
 #include <linux/mtd/nand.h>
 #include <linux/gpio.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -31,6 +30,7 @@
 
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 
 /* FPGA defines */
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index c491756..fc97040 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -20,10 +20,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx1.h"
+#include "hardware.h"
 #include "iomux-mx1.h"
 
 /*
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 288a920..3aecf91 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -28,14 +28,13 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
 #include <linux/mfd/mc13xxx.h>
 
 #include "common.h"
 #include "devices-imx35.h"
+#include "hardware.h"
 #include "iomux-mx35.h"
 
 #define GPIO_LCDPWR	IMX_GPIO_NR(1, 2)
diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index 79f6c0b..7a14667 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -22,10 +22,9 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices/devices-common.h"
+#include "hardware.h"
 #include "iomux-v1.h"
 
 static struct map_desc imx_io_desc[] __initdata = {
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 3b97ea6..8868398 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -21,12 +21,12 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/pinctrl/machine.h>
-#include <mach/hardware.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
 
 #include "common.h"
 #include "devices/devices-common.h"
+#include "hardware.h"
 #include "iomux-v1.h"
 
 /* MX21 memory map definition */
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index a08a960..9be33cd 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -24,12 +24,11 @@
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-#include <mach/mx25.h>
-
 #include "common.h"
 #include "devices/devices-common.h"
+#include "hardware.h"
 #include "iomux-v3.h"
+#include "mx25.h"
 
 /*
  * This table defines static virtual address mappings for I/O regions.
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 91e8da8..ecaa5b9 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -21,12 +21,12 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/pinctrl/machine.h>
-#include <mach/hardware.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
 
 #include "common.h"
 #include "devices/devices-common.h"
+#include "hardware.h"
 #include "iomux-v1.h"
 
 /* MX27 memory map definition */
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 3e2ed2a..072b3bf 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -26,11 +26,10 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "crmregs-imx3.h"
 #include "devices/devices-common.h"
+#include "hardware.h"
 #include "iomux-v3.h"
 
 void __iomem *mx3_ccm_base;
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index d9ef24b..e739553 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -18,10 +18,9 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices/devices-common.h"
+#include "hardware.h"
 #include "iomux-v3.h"
 
 /*
diff --git a/arch/arm/mach-imx/include/mach/mx1.h b/arch/arm/mach-imx/mx1.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx1.h
rename to arch/arm/mach-imx/mx1.h
diff --git a/arch/arm/mach-imx/include/mach/mx21.h b/arch/arm/mach-imx/mx21.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx21.h
rename to arch/arm/mach-imx/mx21.h
diff --git a/arch/arm/mach-imx/include/mach/mx25.h b/arch/arm/mach-imx/mx25.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx25.h
rename to arch/arm/mach-imx/mx25.h
diff --git a/arch/arm/mach-imx/include/mach/mx27.h b/arch/arm/mach-imx/mx27.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx27.h
rename to arch/arm/mach-imx/mx27.h
diff --git a/arch/arm/mach-imx/include/mach/mx2x.h b/arch/arm/mach-imx/mx2x.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx2x.h
rename to arch/arm/mach-imx/mx2x.h
diff --git a/arch/arm/mach-imx/include/mach/mx31.h b/arch/arm/mach-imx/mx31.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx31.h
rename to arch/arm/mach-imx/mx31.h
diff --git a/arch/arm/mach-imx/mx31lilly-db.c b/arch/arm/mach-imx/mx31lilly-db.c
index 8cdcf0f..d4361b8 100644
--- a/arch/arm/mach-imx/mx31lilly-db.c
+++ b/arch/arm/mach-imx/mx31lilly-db.c
@@ -30,11 +30,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "board-mx31lilly.h"
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 
 /*
diff --git a/arch/arm/mach-imx/mx31lite-db.c b/arch/arm/mach-imx/mx31lite-db.c
index c9eb91c..5a160b7 100644
--- a/arch/arm/mach-imx/mx31lite-db.c
+++ b/arch/arm/mach-imx/mx31lite-db.c
@@ -31,11 +31,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-
 #include "board-mx31lite.h"
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 
 /*
diff --git a/arch/arm/mach-imx/mx31moboard-devboard.c b/arch/arm/mach-imx/mx31moboard-devboard.c
index 6489afc..52d5b15 100644
--- a/arch/arm/mach-imx/mx31moboard-devboard.c
+++ b/arch/arm/mach-imx/mx31moboard-devboard.c
@@ -22,10 +22,9 @@
 
 #include <linux/usb/otg.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
index ea973c4..a4f43e9 100644
--- a/arch/arm/mach-imx/mx31moboard-marxbot.c
+++ b/arch/arm/mach-imx/mx31moboard-marxbot.c
@@ -24,12 +24,11 @@
 
 #include <linux/usb/otg.h>
 
-#include <mach/hardware.h>
-
 #include <media/soc_camera.h>
 
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/mx31moboard-smartbot.c b/arch/arm/mach-imx/mx31moboard-smartbot.c
index 807e882..04ae45d 100644
--- a/arch/arm/mach-imx/mx31moboard-smartbot.c
+++ b/arch/arm/mach-imx/mx31moboard-smartbot.c
@@ -23,13 +23,12 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
-#include <mach/hardware.h>
-
 #include <media/soc_camera.h>
 
 #include "board-mx31moboard.h"
 #include "common.h"
 #include "devices-imx31.h"
+#include "hardware.h"
 #include "iomux-mx3.h"
 #include "ulpi.h"
 
diff --git a/arch/arm/mach-imx/include/mach/mx35.h b/arch/arm/mach-imx/mx35.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx35.h
rename to arch/arm/mach-imx/mx35.h
diff --git a/arch/arm/mach-imx/include/mach/mx3x.h b/arch/arm/mach-imx/mx3x.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx3x.h
rename to arch/arm/mach-imx/mx3x.h
diff --git a/arch/arm/mach-imx/include/mach/mx50.h b/arch/arm/mach-imx/mx50.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx50.h
rename to arch/arm/mach-imx/mx50.h
diff --git a/arch/arm/mach-imx/include/mach/mx51.h b/arch/arm/mach-imx/mx51.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx51.h
rename to arch/arm/mach-imx/mx51.h
diff --git a/arch/arm/mach-imx/include/mach/mx53.h b/arch/arm/mach-imx/mx53.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx53.h
rename to arch/arm/mach-imx/mx53.h
diff --git a/arch/arm/mach-imx/include/mach/mx6q.h b/arch/arm/mach-imx/mx6q.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mx6q.h
rename to arch/arm/mach-imx/mx6q.h
diff --git a/arch/arm/mach-imx/include/mach/mxc.h b/arch/arm/mach-imx/mxc.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/mxc.h
rename to arch/arm/mach-imx/mxc.h
diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
index c491f59..51c6082 100644
--- a/arch/arm/mach-imx/pcm970-baseboard.c
+++ b/arch/arm/mach-imx/pcm970-baseboard.c
@@ -23,10 +23,9 @@
 
 #include <asm/mach/arch.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "devices-imx27.h"
+#include "hardware.h"
 #include "iomux-mx27.h"
 
 static const int pcm970_pins[] __initconst = {
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 6147be2..3777b80 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -16,9 +16,9 @@
 #include <asm/smp_scu.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
-#include <mach/hardware.h>
 
 #include "common.h"
+#include "hardware.h"
 
 static void __iomem *scu_base;
 
diff --git a/arch/arm/mach-imx/pm-imx27.c b/arch/arm/mach-imx/pm-imx27.c
index 6fcffa7..56d02d0 100644
--- a/arch/arm/mach-imx/pm-imx27.c
+++ b/arch/arm/mach-imx/pm-imx27.c
@@ -10,7 +10,8 @@
 #include <linux/kernel.h>
 #include <linux/suspend.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
+
+#include "hardware.h"
 
 static int mx27_suspend_enter(suspend_state_t state)
 {
diff --git a/arch/arm/mach-imx/pm-imx3.c b/arch/arm/mach-imx/pm-imx3.c
index e509be0..6a07006 100644
--- a/arch/arm/mach-imx/pm-imx3.c
+++ b/arch/arm/mach-imx/pm-imx3.c
@@ -9,11 +9,11 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 #include <linux/io.h>
-#include <mach/hardware.h>
 
 #include "common.h"
 #include "crmregs-imx3.h"
 #include "devices/devices-common.h"
+#include "hardware.h"
 
 /*
  * Set cpu low power mode before WFI instruction. This function is called
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index a614702..2e063c2 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -16,11 +16,11 @@
 #include <asm/cacheflush.h>
 #include <asm/system_misc.h>
 #include <asm/tlbflush.h>
-#include <mach/hardware.h>
 
 #include "common.h"
 #include "cpuidle.h"
 #include "crm-regs-imx5.h"
+#include "hardware.h"
 
 /*
  * The WAIT_UNCLOCKED_POWER_OFF state only requires <= 500ns to exit.
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 05618af..a17543d 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -18,9 +18,9 @@
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <mach/hardware.h>
 
 #include "common.h"
+#include "hardware.h"
 
 extern unsigned long phys_l2x0_saved_regs;
 
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index bbd80f2..695e0d7 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -22,12 +22,12 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 
-#include <mach/hardware.h>
 #include <asm/system_misc.h>
 #include <asm/proc-fns.h>
 #include <asm/mach-types.h>
 
 #include "common.h"
+#include "hardware.h"
 
 static void __iomem *wdog_base;
 
diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 8ee6f36..f017302 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -27,11 +27,11 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
-#include <mach/hardware.h>
 #include <asm/sched_clock.h>
 #include <asm/mach/time.h>
 
 #include "common.h"
+#include "hardware.h"
 
 /*
  * There are 2 versions of the timer hardware on Freescale MXC hardware.
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 6134e96..c7625b4 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -21,10 +21,10 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 
 #include "common.h"
+#include "hardware.h"
 #include "irq-common.h"
 
 /*
-- 
1.7.9.5
