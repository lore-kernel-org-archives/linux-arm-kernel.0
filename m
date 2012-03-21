From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Wed, 21 Mar 2012 16:28:19 +0530
Subject: [PATCH] ARM: OMAP2+: control: Add AM33XX control reg & sec clkctrl
 offset
Message-ID: <1332327499-29946-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define AM33XX control register, in order to allow access to
control register address space, also add CONTROL_SEC_CLK_CTRL
register offset; both are required in clock tree data,
for wdt0 and timer0 clock source select configuration.

CONTROL.SEC_CLK_CTRL register is provided to select/configure
clock input for WDT0 and TIMER0.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/control.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a406fd0..2858b80 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -28,6 +28,8 @@
 		OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
 		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#define AM33XX_CTRL_REGADDR(reg)					\
+		AM33XX_L4_WK_IO_ADDRESS(AM33XX_SCM_BASE + (reg))
 #else
 #define OMAP242X_CTRL_REGADDR(reg)					\
 		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
@@ -35,6 +37,8 @@
 		OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
 		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#define AM33XX_CTRL_REGADDR(reg)					\
+		AM33XX_L4_WK_IO_ADDRESS(AM33XX_SCM_BASE + (reg))
 #endif /* __ASSEMBLY__ */

 /*
@@ -341,6 +345,7 @@
  * CONTROL AM33XX STATUS register
  */
 #define AM33XX_CONTROL_STATUS		0x040
+#define AM33XX_CONTROL_SEC_CLK_CTRL	0x1bc

 /*
  * CONTROL OMAP STATUS register to identify OMAP3 features
--
1.7.0.4
