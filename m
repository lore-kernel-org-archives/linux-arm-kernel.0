From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Dec 2009 20:00:00 +0100
Subject: [PATCH 19/20] imx35: define and use MX35_IO_ADDRESS
In-Reply-To: <1260990002-24168-18-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091216185046.GA16984@pengutronix.de>
	<1260990002-24168-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-18-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1260990002-24168-19-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c       |    2 +-
 arch/arm/plat-mxc/include/mach/mx35.h |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index e65e862..13a2b86 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -28,7 +28,7 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 
-#define CCM_BASE	IO_ADDRESS(MX35_CCM_BASE_ADDR)
+#define CCM_BASE	MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR)
 
 #define CCM_CCMR        0x00
 #define CCM_PDR0        0x04
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index af871bc..cc5deef 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -104,6 +104,14 @@
 #define MX35_NFC_BASE_ADDR		0xbb000000
 #define MX35_PCMCIA_MEM_BASE_ADDR	0xbc000000
 
+#define MX35_IO_ADDRESS(x)						\
+	(void __force __iomem *) (					\
+	IMX_IO_ADDRESS(x, MX35_AIPS1) ?:				\
+	IMX_IO_ADDRESS(x, MX35_AIPS2) ?:				\
+	IMX_IO_ADDRESS(x, MX35_AVIC) ?:					\
+	IMX_IO_ADDRESS(x, MX35_X_MEMC) ?:				\
+	IMX_IO_ADDRESS(x, MX35_SPBA0) ?:				\
+	0xdeadbeef)
 /*
  * Interrupt numbers
  */
-- 
1.6.5.2
