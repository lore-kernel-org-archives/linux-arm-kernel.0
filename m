From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jan 2012 10:34:11 -0600
Subject: [RFC PATCH 10/10] ARM: highbank: select SPARSE_IRQ and remove irqs.h
In-Reply-To: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326472451-9002-11-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

irqs.h is optional now for SPARSE_IRQ, so select it and remove mach/irqs.h
from highbank.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig                           |    1 +
 arch/arm/mach-highbank/highbank.c          |    1 -
 arch/arm/mach-highbank/include/mach/irqs.h |    6 ------
 3 files changed, 1 insertions(+), 7 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/include/mach/irqs.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24626b0..a3c19cb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -350,6 +350,7 @@ config ARCH_HIGHBANK
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU
 	select HAVE_SMP
+	select SPARSE_IRQ
 	select USE_OF
 	help
 	  Support for the Calxeda Highbank SoC based boards.
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 804c4a5..3257d48 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -34,7 +34,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <mach/irqs.h>
 
 #include "core.h"
 #include "sysregs.h"
diff --git a/arch/arm/mach-highbank/include/mach/irqs.h b/arch/arm/mach-highbank/include/mach/irqs.h
deleted file mode 100644
index 9746aab..0000000
--- a/arch/arm/mach-highbank/include/mach/irqs.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __MACH_IRQS_H
-#define __MACH_IRQS_H
-
-#define NR_IRQS			192
-
-#endif
-- 
1.7.5.4
