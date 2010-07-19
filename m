From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 19 Jul 2010 12:59:04 +0200
Subject: [PATCH 9/9] [ARM] mmp: move declarations into SoC specific header
	file from common.h
In-Reply-To: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
References: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1279537144-25424-9-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/common.h              |    9 ---------
 arch/arm/mach-mmp/include/mach/mmp2.h   |    7 +++++++
 arch/arm/mach-mmp/include/mach/pxa168.h |    5 +++++
 arch/arm/mach-mmp/include/mach/pxa910.h |    5 +++++
 arch/arm/mach-mmp/irq-mmp2.c            |    1 +
 arch/arm/mach-mmp/mmp2.c                |    1 +
 6 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 9696175..ec8d65d 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -3,15 +3,6 @@
 struct sys_timer;
 
 extern void timer_init(int irq);
-extern void mmp2_clear_pmic_int(void);
-
-extern struct sys_timer pxa168_timer;
-extern struct sys_timer pxa910_timer;
-extern struct sys_timer mmp2_timer;
-extern void __init pxa168_init_irq(void);
-extern void __init pxa910_init_irq(void);
-extern void __init mmp2_init_icu(void);
-extern void __init mmp2_init_irq(void);
 
 extern void __init icu_init_irq(void);
 extern void __init mmp_map_io(void);
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index fec220b..dbba6e8 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -1,6 +1,13 @@
 #ifndef __ASM_MACH_MMP2_H
 #define __ASM_MACH_MMP2_H
 
+struct sys_timer;
+
+extern struct sys_timer mmp2_timer;
+extern void __init mmp2_init_icu(void);
+extern void __init mmp2_init_irq(void);
+extern void mmp2_clear_pmic_int(void);
+
 #include <linux/i2c.h>
 #include <mach/devices.h>
 #include <plat/i2c.h>
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 3b2bd5d..27e1bc7 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -1,6 +1,11 @@
 #ifndef __ASM_MACH_PXA168_H
 #define __ASM_MACH_PXA168_H
 
+struct sys_timer;
+
+extern struct sys_timer pxa168_timer;
+extern void __init pxa168_init_irq(void);
+
 #include <linux/i2c.h>
 #include <mach/devices.h>
 #include <plat/i2c.h>
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index 4f0b4ec..f13c49d 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -1,6 +1,11 @@
 #ifndef __ASM_MACH_PXA910_H
 #define __ASM_MACH_PXA910_H
 
+struct sys_timer;
+
+extern struct sys_timer pxa910_timer;
+extern void __init pxa910_init_irq(void);
+
 #include <linux/i2c.h>
 #include <mach/devices.h>
 #include <plat/i2c.h>
diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
index cb18221..01342be 100644
--- a/arch/arm/mach-mmp/irq-mmp2.c
+++ b/arch/arm/mach-mmp/irq-mmp2.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 
 #include <mach/regs-icu.h>
+#include <mach/mmp2.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index b3fddac..daf3993 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -27,6 +27,7 @@
 #include <mach/mfp.h>
 #include <mach/gpio.h>
 #include <mach/devices.h>
+#include <mach/mmp2.h>
 
 #include "common.h"
 #include "clock.h"
-- 
1.7.1
