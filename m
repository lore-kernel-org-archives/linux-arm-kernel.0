From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 15:12:52 -0500
Subject: [PATCH 09/12] ARM: vexpress: remove dependency on mach/* headers
In-Reply-To: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346962375-26163-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/ct-ca9x4.c          |    1 +
 arch/arm/mach-vexpress/include/mach/irqs.h |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 61c4924..0e770e8 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -27,6 +27,7 @@
 #include "core.h"
 
 #include <mach/motherboard.h>
+#include <mach/irqs.h>
 
 #include <plat/clcd.h>
 
diff --git a/arch/arm/mach-vexpress/include/mach/irqs.h b/arch/arm/mach-vexpress/include/mach/irqs.h
index 4b10ee7..f8f7f78 100644
--- a/arch/arm/mach-vexpress/include/mach/irqs.h
+++ b/arch/arm/mach-vexpress/include/mach/irqs.h
@@ -1,4 +1,6 @@
 #define IRQ_LOCALTIMER		29
 #define IRQ_LOCALWDOG		30
 
+#ifndef CONFIG_SPARSE_IRQ
 #define NR_IRQS	256
+#endif
-- 
1.7.9.5
