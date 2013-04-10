From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Apr 2013 14:57:15 +0530
Subject: [PATCH 4/4] ARM: davinci: ensure global variables are declared
In-Reply-To: <1365586035-26583-1-git-send-email-nsekhar@ti.com>
References: <1365586035-26583-1-git-send-email-nsekhar@ti.com>
Message-ID: <1365586035-26583-5-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warnings by declaring relevant
global variables.

  CHECK   arch/arm/mach-davinci/usb.c
arch/arm/mach-davinci/usb.c:134:12: warning: symbol 'da8xx_register_usb20' was not declared. Should it be static?
arch/arm/mach-davinci/usb.c:169:12: warning: symbol 'da8xx_register_usb11' was not declared. Should it be static?

  CHECK   arch/arm/mach-davinci/pm.c
arch/arm/mach-davinci/pm.c:155:12: warning: symbol 'davinci_pm_init' was not declared. Should it be static?

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/pm.c  |    1 +
 arch/arm/mach-davinci/usb.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index eb8360b..a508fe5 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -19,6 +19,7 @@
 #include <asm/delay.h>
 #include <asm/io.h>
 
+#include <mach/common.h>
 #include <mach/da8xx.h>
 #include <mach/sram.h>
 #include <mach/pm.h>
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index 34509ff..2b4c648 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -10,6 +10,7 @@
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/cputype.h>
+#include <mach/da8xx.h>
 #include <linux/platform_data/usb-davinci.h>
 
 #define DAVINCI_USB_OTG_BASE	0x01c64000
-- 
1.7.10.1
