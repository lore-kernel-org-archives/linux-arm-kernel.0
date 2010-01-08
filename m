From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:31 +0100
Subject: [PATCH 24/25] imx: properly protect mach/mx{1,
	[25][157x]}.h from multiple inclusion
In-Reply-To: <1262967452-24353-23-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-18-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-19-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-20-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-21-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-22-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-23-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-24-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some headers have used (now) wrong names or havn't had protection at
all.  This is needed before adding static inline functions to the
headers.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Magnus Lilja <lilja.magnus@gmail.com>
Cc: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/plat-mxc/include/mach/mx1.h  |    6 +++---
 arch/arm/plat-mxc/include/mach/mx21.h |    6 +++---
 arch/arm/plat-mxc/include/mach/mx25.h |    2 +-
 arch/arm/plat-mxc/include/mach/mx27.h |    6 +++---
 arch/arm/plat-mxc/include/mach/mx2x.h |    6 +++---
 arch/arm/plat-mxc/include/mach/mx31.h |    5 +++++
 arch/arm/plat-mxc/include/mach/mx35.h |    4 ++++
 arch/arm/plat-mxc/include/mach/mx3x.h |    6 +++---
 8 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index 1b2890a..b652a9c 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -9,8 +9,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __ASM_ARCH_MXC_MX1_H__
-#define __ASM_ARCH_MXC_MX1_H__
+#ifndef __MACH_MX1_H__
+#define __MACH_MX1_H__
 
 #include <mach/vmalloc.h>
 
@@ -161,4 +161,4 @@
 #define DMA_REQ_UART1_T		30
 #define DMA_REQ_UART1_R		31
 
-#endif /*  __ASM_ARCH_MXC_MX1_H__ */
+#endif /* ifndef __MACH_MX1_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/mx21.h b/arch/arm/plat-mxc/include/mach/mx21.h
index 5e2f16e..ed98b9c 100644
--- a/arch/arm/plat-mxc/include/mach/mx21.h
+++ b/arch/arm/plat-mxc/include/mach/mx21.h
@@ -22,8 +22,8 @@
  * MA  02110-1301, USA.
  */
 
-#ifndef __ASM_ARCH_MXC_MX21_H__
-#define __ASM_ARCH_MXC_MX21_H__
+#ifndef __MACH_MX21_H__
+#define __MACH_MX21_H__
 
 #define MX21_AIPI_BASE_ADDR		0x10000000
 #define MX21_AIPI_BASE_ADDR_VIRT	0xf4000000
@@ -219,4 +219,4 @@
 #define DMA_REQ_BMI_RX MX21_DMA_REQ_BMI_RX
 #endif
 
-#endif /* __ASM_ARCH_MXC_MX21_H__ */
+#endif /* ifndef __MACH_MX21_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 7a8982d..18eb44c 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -34,4 +34,4 @@
 
 #define MX25_INT_FEC	57
 
-#endif /* __MACH_MX25_H__ */
+#endif /* ifndef __MACH_MX25_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index 62746c0..832b580 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -21,8 +21,8 @@
  * MA  02110-1301, USA.
  */
 
-#ifndef __ASM_ARCH_MXC_MX27_H__
-#define __ASM_ARCH_MXC_MX27_H__
+#ifndef __MACH_MX27_H__
+#define __MACH_MX27_H__
 
 #define MX27_AIPI_BASE_ADDR		0x10000000
 #define MX27_AIPI_BASE_ADDR_VIRT	0xf4000000
@@ -300,4 +300,4 @@ extern int mx27_revision(void);
 #define DMA_REQ_NFC MX27_DMA_REQ_NFC
 #endif
 
-#endif /* __ASM_ARCH_MXC_MX27_H__ */
+#endif /* ifndef __MACH_MX27_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/mx2x.h b/arch/arm/plat-mxc/include/mach/mx2x.h
index 396470e..afb895a 100644
--- a/arch/arm/plat-mxc/include/mach/mx2x.h
+++ b/arch/arm/plat-mxc/include/mach/mx2x.h
@@ -20,8 +20,8 @@
  * MA  02110-1301, USA.
  */
 
-#ifndef __ASM_ARCH_MXC_MX2x_H__
-#define __ASM_ARCH_MXC_MX2x_H__
+#ifndef __MACH_MX2x_H__
+#define __MACH_MX2x_H__
 
 /* The following addresses are common between i.MX21 and i.MX27 */
 
@@ -290,4 +290,4 @@
 #define DMA_REQ_CSI_RX MX2x_DMA_REQ_CSI_RX
 #endif
 
-#endif /* __ASM_ARCH_MXC_MX2x_H__ */
+#endif /* ifndef __MACH_MX2x_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index 53da4c5..62d26da 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -1,3 +1,6 @@
+#ifndef __MACH_MX31_H__
+#define __MACH_MX31_H__
+
 /*
  * IRAM
  */
@@ -225,3 +228,5 @@
 #define MXC_INT_CCM MX31_INT_CCM
 #define MXC_INT_PCMCIA MX31_INT_PCMCIA
 #endif
+
+#endif /* ifndef __MACH_MX31_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index ff2d2f0..526a558 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -1,3 +1,5 @@
+#ifndef __MACH_MX35_H__
+#define __MACH_MX35_H__
 /*
  * IRAM
  */
@@ -204,3 +206,5 @@
 #define MXC_INT_SPDIF MX35_INT_SPDIF
 #define MXC_INT_FEC MX35_INT_FEC
 #endif
+
+#endif /* ifndef __MACH_MX35_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index 5ae0b00..7a356de 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -8,8 +8,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __ASM_ARCH_MXC_MX31_H__
-#define __ASM_ARCH_MXC_MX31_H__
+#ifndef __MACH_MX3x_H__
+#define __MACH_MX3x_H__
 
 /*
  * MX31 memory map:
@@ -404,4 +404,4 @@ static inline int mx31_revision(void)
 #define SYSTEM_REV_NUM MX3x_SYSTEM_REV_NUM
 #endif
 
-#endif /*  __ASM_ARCH_MXC_MX31_H__ */
+#endif /* ifndef __MACH_MX3x_H__ */
-- 
1.6.5.2
