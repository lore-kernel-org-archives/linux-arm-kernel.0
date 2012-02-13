From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 15:43:20 -0600
Subject: [PATCH 07/15] ARM: at91: clean-up mach/io.h
In-Reply-To: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329169408-17253-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move most of io.h into at91_io.h and update includes.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-at91/at91cap9.c                     |    1 +
 arch/arm/mach-at91/at91cap9_devices.c             |    1 +
 arch/arm/mach-at91/at91rm9200.c                   |    1 +
 arch/arm/mach-at91/at91rm9200_devices.c           |    1 +
 arch/arm/mach-at91/at91rm9200_time.c              |    1 +
 arch/arm/mach-at91/at91sam9260.c                  |    1 +
 arch/arm/mach-at91/at91sam9260_devices.c          |    1 +
 arch/arm/mach-at91/at91sam9261.c                  |    1 +
 arch/arm/mach-at91/at91sam9261_devices.c          |    1 +
 arch/arm/mach-at91/at91sam9263.c                  |    1 +
 arch/arm/mach-at91/at91sam9263_devices.c          |    1 +
 arch/arm/mach-at91/at91sam9g45.c                  |    1 +
 arch/arm/mach-at91/at91sam9g45_devices.c          |    1 +
 arch/arm/mach-at91/at91sam9rl.c                   |    1 +
 arch/arm/mach-at91/at91sam9rl_devices.c           |    1 +
 arch/arm/mach-at91/at91x40.c                      |    1 +
 arch/arm/mach-at91/at91x40_time.c                 |    1 +
 arch/arm/mach-at91/board-cap9adk.c                |    1 +
 arch/arm/mach-at91/board-cpu9krea.c               |    1 +
 arch/arm/mach-at91/board-eco920.c                 |    1 +
 arch/arm/mach-at91/board-yl-9200.c                |    1 +
 arch/arm/mach-at91/clock.c                        |    1 +
 arch/arm/mach-at91/include/mach/at91_io.h         |   44 +++++++++++++++++++++
 arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h |    2 +
 arch/arm/mach-at91/include/mach/at91sam9_sdramc.h |    2 +
 arch/arm/mach-at91/include/mach/uncompress.h      |    1 +
 arch/arm/mach-at91/pm.c                           |    1 +
 arch/arm/mach-at91/pm.h                           |    2 +
 arch/arm/mach-at91/setup.c                        |    1 +
 drivers/pcmcia/at91_cf.c                          |    1 +
 drivers/rtc/rtc-at91sam9.c                        |    2 +-
 drivers/usb/gadget/at91_udc.c                     |    1 +
 drivers/watchdog/at91rm9200_wdt.c                 |    1 +
 drivers/watchdog/at91sam9_wdt.c                   |    1 +
 34 files changed, 80 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/at91_io.h

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index a42edc2..1fc7082 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -21,6 +21,7 @@
 #include <mach/cpu.h>
 #include <mach/at91cap9.h>
 #include <mach/at91_pmc.h>
+#include <mach/at91_io.h>
 
 #include "soc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index d298fb7..f2edf2d 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -27,6 +27,7 @@
 #include <mach/at91cap9.h>
 #include <mach/at91cap9_matrix.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/at91_io.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 99c3174..e8a4d50 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -19,6 +19,7 @@
 #include <mach/at91_pmc.h>
 #include <mach/at91_st.h>
 #include <mach/cpu.h>
+#include <mach/at91_io.h>
 
 #include "soc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 18bacec..1566d68 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -21,6 +21,7 @@
 #include <mach/board.h>
 #include <mach/at91rm9200.h>
 #include <mach/at91rm9200_mc.h>
+#include <mach/at91_io.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index a028cdf..45bddca 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -27,6 +27,7 @@
 #include <asm/mach/time.h>
 
 #include <mach/at91_st.h>
+#include <mach/at91_io.h>
 
 static unsigned long last_crtr;
 static u32 irqmask;
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index d4036ba..5aa78fa 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -20,6 +20,7 @@
 #include <mach/at91sam9260.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
+#include <mach/at91_io.h>
 
 #include "soc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 642ccb6..94fdf96 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -22,6 +22,7 @@
 #include <mach/at91sam9260.h>
 #include <mach/at91sam9260_matrix.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/at91_io.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 023c2ff..3b4aec7 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -19,6 +19,7 @@
 #include <mach/at91sam9261.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
+#include <mach/at91_io.h>
 
 #include "soc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index fc59cbd..bbd04c2 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -25,6 +25,7 @@
 #include <mach/at91sam9261.h>
 #include <mach/at91sam9261_matrix.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/at91_io.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 75e876c..2e1a428 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -18,6 +18,7 @@
 #include <mach/at91sam9263.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
+#include <mach/at91_io.h>
 
 #include "soc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 7b46b27..1e5e88d 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -24,6 +24,7 @@
 #include <mach/at91sam9263.h>
 #include <mach/at91sam9263_matrix.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/at91_io.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 1cb6a96..2f2e061 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -19,6 +19,7 @@
 #include <mach/at91sam9g45.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
+#include <mach/at91_io.h>
 
 #include "soc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index b7582dd..9e0de74 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -27,6 +27,7 @@
 #include <mach/at91sam9_smc.h>
 #include <mach/at_hdmac.h>
 #include <mach/atmel-mci.h>
+#include <mach/at91_io.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index d2c91a8..c284d98 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -19,6 +19,7 @@
 #include <mach/at91sam9rl.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
+#include <mach/at91_io.h>
 
 #include "soc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 61908dc..3311106 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -22,6 +22,7 @@
 #include <mach/at91sam9rl_matrix.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at_hdmac.h>
+#include <mach/at91_io.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index 56ba3bd..838103e 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -17,6 +17,7 @@
 #include <mach/at91x40.h>
 #include <mach/at91_st.h>
 #include <mach/timex.h>
+#include <mach/at91_io.h>
 #include "generic.h"
 
 /*
diff --git a/arch/arm/mach-at91/at91x40_time.c b/arch/arm/mach-at91/at91x40_time.c
index dfff289..152cc7a 100644
--- a/arch/arm/mach-at91/at91x40_time.c
+++ b/arch/arm/mach-at91/at91x40_time.c
@@ -27,6 +27,7 @@
 #include <mach/hardware.h>
 #include <asm/mach/time.h>
 #include <mach/at91_tc.h>
+#include <mach/at91_io.h>
 
 /*
  *	3 counter/timer units present.
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index ac3de4f..b31791a 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -44,6 +44,7 @@
 #include <mach/board.h>
 #include <mach/at91cap9_matrix.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/at91_io.h>
 #include <mach/system_rev.h>
 
 #include "sam9_smc.h"
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 9ab3d1e..619d1d0 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -43,6 +43,7 @@
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91sam9260_matrix.h>
+#include <mach/at91_io.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 07ef35b..f56bf24 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -27,6 +27,7 @@
 #include <mach/board.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/cpu.h>
+#include <mach/at91_io.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index bbd553e..bf889e5 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -46,6 +46,7 @@
 #include <mach/board.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/cpu.h>
+#include <mach/at91_io.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 61873f3..0e8b318 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -27,6 +27,7 @@
 #include <mach/hardware.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
+#include <mach/at91_io.h>
 
 #include "clock.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/include/mach/at91_io.h b/arch/arm/mach-at91/include/mach/at91_io.h
new file mode 100644
index 0000000..82e66de
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/at91_io.h
@@ -0,0 +1,44 @@
+/*
+ * arch/arm/mach-at91/include/mach/io.h
+ *
+ *  Copyright (C) 2003 SAN People
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_IO_H
+#define __ASM_ARCH_IO_H
+
+#include <mach/hardware.h>
+
+#ifndef __ASSEMBLY__
+
+static inline unsigned int at91_sys_read(unsigned int reg_offset)
+{
+	void __iomem *addr = (void __iomem *)AT91_VA_BASE_SYS;
+
+	return __raw_readl(addr + reg_offset);
+}
+
+static inline void at91_sys_write(unsigned int reg_offset, unsigned long value)
+{
+	void __iomem *addr = (void __iomem *)AT91_VA_BASE_SYS;
+
+	__raw_writel(value, addr + reg_offset);
+}
+
+#endif
+
+#endif
diff --git a/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h b/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
index e2f8da8..0427212 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
@@ -12,6 +12,8 @@
 #ifndef AT91SAM9_DDRSDR_H
 #define AT91SAM9_DDRSDR_H
 
+#include <mach/at91_io.h>
+
 #define AT91_DDRSDRC_MR		0x00	/* Mode Register */
 #define		AT91_DDRSDRC_MODE	(0x7 << 0)		/* Command Mode */
 #define			AT91_DDRSDRC_MODE_NORMAL	0
diff --git a/arch/arm/mach-at91/include/mach/at91sam9_sdramc.h b/arch/arm/mach-at91/include/mach/at91sam9_sdramc.h
index 100f5a5..4a3b2ec 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9_sdramc.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9_sdramc.h
@@ -16,6 +16,8 @@
 #ifndef AT91SAM9_SDRAMC_H
 #define AT91SAM9_SDRAMC_H
 
+#include <mach/at91_io.h>
+
 /* SDRAM Controller (SDRAMC) registers */
 #define AT91_SDRAMC_MR		0x00	/* SDRAM Controller Mode Register */
 #define		AT91_SDRAMC_MODE	(0xf << 0)		/* Command Mode */
diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index 0234fd9..96dd8e1 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -23,6 +23,7 @@
 
 #include <linux/io.h>
 #include <linux/atmel_serial.h>
+#include <mach/at91_io.h>
 
 #if defined(CONFIG_AT91_EARLY_DBGU0)
 #define UART_OFFSET AT91_BASE_DBGU0
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 1606379..f099c3e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -27,6 +27,7 @@
 
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
+#include <mach/at91_io.h>
 
 #include "generic.h"
 #include "pm.h"
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 7eb40d2..ac12592 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -1,3 +1,5 @@
+#include <mach/at91_io.h>
+
 #ifdef CONFIG_ARCH_AT91RM9200
 #include <mach/at91rm9200_mc.h>
 
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 69d3fc4..cee8156 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -17,6 +17,7 @@
 #include <mach/at91_dbgu.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_shdwc.h>
+#include <mach/at91_io.h>
 
 #include "soc.h"
 #include "generic.h"
diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 4902206..3edf52b 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -26,6 +26,7 @@
 
 #include <mach/board.h>
 #include <mach/at91rm9200_mc.h>
+#include <mach/at91_io.h>
 
 
 /*
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index a3ad957..d044f55 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -23,7 +23,7 @@
 #include <mach/board.h>
 #include <mach/at91_rtt.h>
 #include <mach/cpu.h>
-
+#include <mach/at91_io.h>
 
 /*
  * This driver uses two configurable hardware resources that live in the
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 143a725..e9da936 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -41,6 +41,7 @@
 #include <mach/board.h>
 #include <mach/cpu.h>
 #include <mach/at91sam9261_matrix.h>
+#include <mach/at91_io.h>
 
 #include "at91_udc.h"
 
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index b3046dc..4073312 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
+#include <mach/at91_io.h>
 #include <mach/at91_st.h>
 
 #define WDT_DEFAULT_TIME	5	/* seconds */
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 0056256..d4c0576 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
 
+#include <mach/at91_io.h>
 #include "at91sam9_wdt.h"
 
 #define DRV_NAME "AT91SAM9 Watchdog"
-- 
1.7.5.4
