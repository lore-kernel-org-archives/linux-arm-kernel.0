From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Dec 2009 19:59:45 +0100
Subject: [PATCH 04/20] imx/clock-imx27: use a macro to define registers
In-Reply-To: <1260990002-24168-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091216185046.GA16984@pengutronix.de>
	<1260990002-24168-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1260990002-24168-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This way the base address isn't hard coded in each register definition

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rabin Vincent <rabin@rab.in>
Cc: Javier Martin <javier.martin@vista-silicon.com>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx2/clock_imx27.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
index b010bf9..a533208 100644
--- a/arch/arm/mach-mx2/clock_imx27.c
+++ b/arch/arm/mach-mx2/clock_imx27.c
@@ -29,21 +29,23 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 
+#define IO_ADDR_CCM(off)	(IO_ADDRESS(CCM_BASE_ADDR) + (off))
+
 /* Register offsets */
-#define CCM_CSCR                (IO_ADDRESS(CCM_BASE_ADDR) + 0x0)
-#define CCM_MPCTL0              (IO_ADDRESS(CCM_BASE_ADDR) + 0x4)
-#define CCM_MPCTL1              (IO_ADDRESS(CCM_BASE_ADDR) + 0x8)
-#define CCM_SPCTL0              (IO_ADDRESS(CCM_BASE_ADDR) + 0xC)
-#define CCM_SPCTL1              (IO_ADDRESS(CCM_BASE_ADDR) + 0x10)
-#define CCM_OSC26MCTL           (IO_ADDRESS(CCM_BASE_ADDR) + 0x14)
-#define CCM_PCDR0               (IO_ADDRESS(CCM_BASE_ADDR) + 0x18)
-#define CCM_PCDR1               (IO_ADDRESS(CCM_BASE_ADDR) + 0x1c)
-#define CCM_PCCR0               (IO_ADDRESS(CCM_BASE_ADDR) + 0x20)
-#define CCM_PCCR1               (IO_ADDRESS(CCM_BASE_ADDR) + 0x24)
-#define CCM_CCSR                (IO_ADDRESS(CCM_BASE_ADDR) + 0x28)
-#define CCM_PMCTL               (IO_ADDRESS(CCM_BASE_ADDR) + 0x2c)
-#define CCM_PMCOUNT             (IO_ADDRESS(CCM_BASE_ADDR) + 0x30)
-#define CCM_WKGDCTL             (IO_ADDRESS(CCM_BASE_ADDR) + 0x34)
+#define CCM_CSCR		IO_ADDR_CCM(0x0)
+#define CCM_MPCTL0		IO_ADDR_CCM(0x4)
+#define CCM_MPCTL1		IO_ADDR_CCM(0x8)
+#define CCM_SPCTL0		IO_ADDR_CCM(0xc)
+#define CCM_SPCTL1		IO_ADDR_CCM(0x10)
+#define CCM_OSC26MCTL		IO_ADDR_CCM(0x14)
+#define CCM_PCDR0		IO_ADDR_CCM(0x18)
+#define CCM_PCDR1		IO_ADDR_CCM(0x1c)
+#define CCM_PCCR0		IO_ADDR_CCM(0x20)
+#define CCM_PCCR1		IO_ADDR_CCM(0x24)
+#define CCM_CCSR		IO_ADDR_CCM(0x28)
+#define CCM_PMCTL		IO_ADDR_CCM(0x2c)
+#define CCM_PMCOUNT		IO_ADDR_CCM(0x30)
+#define CCM_WKGDCTL		IO_ADDR_CCM(0x34)
 
 #define CCM_CSCR_UPDATE_DIS	(1 << 31)
 #define CCM_CSCR_SSI2		(1 << 23)
-- 
1.6.5.2
