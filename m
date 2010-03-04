From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Improve documentation in arm_timer.h
References: <git-1267729916-7c3bc54da04080b7c4c3974b8eefeecfe43f2c83@rmk-PC>
Message-ID: <git-1267729916-ba63a72aebef1bae1a2e1f7b7f0cd58805108927@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/arm_timer.h |   39 +++++++++++++++++-----------
 1 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/hardware/arm_timer.h b/arch/arm/include/asm/hardware/arm_timer.h
index 04be3bd..c0f4e7b 100644
--- a/arch/arm/include/asm/hardware/arm_timer.h
+++ b/arch/arm/include/asm/hardware/arm_timer.h
@@ -1,21 +1,30 @@
 #ifndef __ASM_ARM_HARDWARE_ARM_TIMER_H
 #define __ASM_ARM_HARDWARE_ARM_TIMER_H
 
-#define TIMER_LOAD	0x00
-#define TIMER_VALUE	0x04
-#define TIMER_CTRL	0x08
-#define TIMER_CTRL_ONESHOT	(1 << 0)
-#define TIMER_CTRL_32BIT	(1 << 1)
-#define TIMER_CTRL_DIV1		(0 << 2)
-#define TIMER_CTRL_DIV16	(1 << 2)
-#define TIMER_CTRL_DIV256	(2 << 2)
-#define TIMER_CTRL_IE		(1 << 5)	/* Interrupt Enable (versatile only) */
-#define TIMER_CTRL_PERIODIC	(1 << 6)
-#define TIMER_CTRL_ENABLE	(1 << 7)
+/*
+ * ARM timer implementation, found in Integrator, Versatile and Realview
+ * platforms.  Not all platforms support all registers and bits in these
+ * registers, so we mark them with A for Integrator AP, C for Integrator
+ * CP, V for Versatile and R for Realview.
+ *
+ * Integrator AP has 16-bit timers, Integrator CP, Versatile and Realview
+ * can have 16-bit or 32-bit selectable via a bit in the control register.
+ */
+#define TIMER_LOAD	0x00			/* ACVR rw */
+#define TIMER_VALUE	0x04			/* ACVR ro */
+#define TIMER_CTRL	0x08			/* ACVR rw */
+#define TIMER_CTRL_ONESHOT	(1 << 0)	/*  CVR */
+#define TIMER_CTRL_32BIT	(1 << 1)	/*  CVR */
+#define TIMER_CTRL_DIV1		(0 << 2)	/* ACVR */
+#define TIMER_CTRL_DIV16	(1 << 2)	/* ACVR */
+#define TIMER_CTRL_DIV256	(2 << 2)	/* ACVR */
+#define TIMER_CTRL_IE		(1 << 5)	/*   VR */
+#define TIMER_CTRL_PERIODIC	(1 << 6)	/* ACVR */
+#define TIMER_CTRL_ENABLE	(1 << 7)	/* ACVR */
 
-#define TIMER_INTCLR	0x0c
-#define TIMER_RIS	0x10
-#define TIMER_MIS	0x14
-#define TIMER_BGLOAD	0x18
+#define TIMER_INTCLR	0x0c			/* ACVR wo */
+#define TIMER_RIS	0x10			/*  CVR ro */
+#define TIMER_MIS	0x14			/*  CVR ro */
+#define TIMER_BGLOAD	0x18			/*  CVR rw */
 
 #endif
