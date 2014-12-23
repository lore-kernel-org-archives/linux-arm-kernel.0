From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 24 Dec 2014 01:14:14 +0300
Subject: [PATCH] arm: sa1100: move irda header to linux/platform_data
Message-ID: <1419372854-14840-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the end asm/mach/irda.h header is not used by anybody except sa1100.
Move the header to the platform data includes dir and rename it to
irda-sa11x0.h.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/assabet.c                                          | 2 +-
 arch/arm/mach-sa1100/collie.c                                           | 2 +-
 arch/arm/mach-sa1100/h3100.c                                            | 2 +-
 arch/arm/mach-sa1100/h3600.c                                            | 2 +-
 drivers/net/irda/sa1100_ir.c                                            | 2 +-
 .../asm/mach/irda.h => include/linux/platform_data/irda-sa11x0.h        | 0
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/include/asm/mach/irda.h => include/linux/platform_data/irda-sa11x0.h (100%)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 7dd894e..d28ecb9 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -37,7 +37,7 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
-#include <asm/mach/irda.h>
+#include <linux/platform_data/irda-sa11x0.h>
 #include <asm/mach/map.h>
 #include <mach/assabet.h>
 #include <linux/platform_data/mfd-mcp-sa11x0.h>
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 108939f..0a816e2 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -43,7 +43,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/irda.h>
+#include <linux/platform_data/irda-sa11x0.h>
 
 #include <asm/hardware/scoop.h>
 #include <asm/mach/sharpsl_param.h>
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index 3c43219..c6b4120 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -18,7 +18,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/irda.h>
+#include <linux/platform_data/irda-sa11x0.h>
 
 #include <mach/h3xxx.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 5be54c2..118338e 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -18,7 +18,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/irda.h>
+#include <linux/platform_data/irda-sa11x0.h>
 
 #include <mach/h3xxx.h>
 #include <mach/irqs.h>
diff --git a/drivers/net/irda/sa1100_ir.c b/drivers/net/irda/sa1100_ir.c
index 42fde9e..dd14722 100644
--- a/drivers/net/irda/sa1100_ir.c
+++ b/drivers/net/irda/sa1100_ir.c
@@ -38,7 +38,7 @@
 #include <net/irda/irda_device.h>
 
 #include <mach/hardware.h>
-#include <asm/mach/irda.h>
+#include <linux/platform_data/irda-sa11x0.h>
 
 static int power_level = 3;
 static int tx_lpm;
diff --git a/arch/arm/include/asm/mach/irda.h b/include/linux/platform_data/irda-sa11x0.h
similarity index 100%
rename from arch/arm/include/asm/mach/irda.h
rename to include/linux/platform_data/irda-sa11x0.h
-- 
2.1.3
