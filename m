From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Dec 2009 19:59:58 +0100
Subject: [PATCH 17/20] imx31: define and use MX31_IO_ADDRESS
In-Reply-To: <1260990002-24168-16-git-send-email-u.kleine-koenig@pengutronix.de>
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
Message-ID: <1260990002-24168-17-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx31.c                |    3 ++-
 arch/arm/mach-mx3/crm_regs.h                   |    2 +-
 arch/arm/mach-mx3/iomux-imx31.c                |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31ads.h |    2 +-
 arch/arm/plat-mxc/include/mach/mx31.h          |    9 +++++++++
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
index cc03a61..d22a66f 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-mx3/clock-imx31.c
@@ -625,7 +625,8 @@ int __init mx31_clocks_init(unsigned long fref)
 		__raw_writel(reg, MXC_CCM_PMCR1);
 	}
 
-	mxc_timer_init(&ipg_clk, IO_ADDRESS(MX31_GPT1_BASE_ADDR), MX31_INT_GPT);
+	mxc_timer_init(&ipg_clk, MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR),
+			MX31_INT_GPT);
 
 	return 0;
 }
diff --git a/arch/arm/mach-mx3/crm_regs.h b/arch/arm/mach-mx3/crm_regs.h
index e25cd92..37a8a07 100644
--- a/arch/arm/mach-mx3/crm_regs.h
+++ b/arch/arm/mach-mx3/crm_regs.h
@@ -24,7 +24,7 @@
 #define CKIH_CLK_FREQ_27MHZ     27000000
 #define CKIL_CLK_FREQ           32768
 
-#define MXC_CCM_BASE		IO_ADDRESS(MX31_CCM_BASE_ADDR)
+#define MXC_CCM_BASE		MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR)
 
 /* Register addresses */
 #define MXC_CCM_CCMR		(MXC_CCM_BASE + 0x00)
diff --git a/arch/arm/mach-mx3/iomux-imx31.c b/arch/arm/mach-mx3/iomux-imx31.c
index 6381e56..a1d7fa5 100644
--- a/arch/arm/mach-mx3/iomux-imx31.c
+++ b/arch/arm/mach-mx3/iomux-imx31.c
@@ -29,7 +29,7 @@
 /*
  * IOMUX register (base) addresses
  */
-#define IOMUX_BASE	IO_ADDRESS(MX31_IOMUXC_BASE_ADDR)
+#define IOMUX_BASE	MX31_IO_ADDRESS(MX31_IOMUXC_BASE_ADDR)
 #define IOMUXINT_OBS1	(IOMUX_BASE + 0x000)
 #define IOMUXINT_OBS2	(IOMUX_BASE + 0x004)
 #define IOMUXGPR	(IOMUX_BASE + 0x008)
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31ads.h b/arch/arm/plat-mxc/include/mach/board-mx31ads.h
index 2cbfa35..095a199 100644
--- a/arch/arm/plat-mxc/include/mach/board-mx31ads.h
+++ b/arch/arm/plat-mxc/include/mach/board-mx31ads.h
@@ -14,7 +14,7 @@
 #include <mach/hardware.h>
 
 /* Base address of PBC controller */
-#define PBC_BASE_ADDRESS        IO_ADDRESS(CS4_BASE_ADDR)
+#define PBC_BASE_ADDRESS        MX31_CS4_BASE_ADDR_VIRT
 /* Offsets for the PBC Controller register */
 
 /* PBC Board status register offset */
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index b8b47d1..e37d317 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -109,6 +109,15 @@
 
 #define MX31_PCMCIA_MEM_BASE_ADDR	0xbc000000
 
+#define MX31_IO_ADDRESS(x)						\
+	(void __force __iomem *) (					\
+	IMX_IO_ADDRESS(x, MX31_AIPS1) ?:				\
+	IMX_IO_ADDRESS(x, MX31_AIPS2) ?:				\
+	IMX_IO_ADDRESS(x, MX31_AVIC) ?:					\
+	IMX_IO_ADDRESS(x, MX31_X_MEMC) ?:				\
+	IMX_IO_ADDRESS(x, MX31_SPBA0) ?:				\
+	0xdeadbeef)
+
 #define MX31_INT_I2C3		3
 #define MX31_INT_I2C2		4
 #define MX31_INT_MPEG4_ENCODER	5
-- 
1.6.5.2
