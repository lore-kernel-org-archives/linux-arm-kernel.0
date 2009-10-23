From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 23 Oct 2009 18:47:00 +0200
Subject: [PATCH] Enable TCM on the Nomadik
Message-ID: <1256316420-29515-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the 8KiB ITCM + 8KiB DTCM found on the Nomadik board
and its derivates.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.se>
Cc: Alessandro Rubini <rubini-list@gnudd.com>
---
I don't have a Nomadik board so I cannot test this really, but I
hope Alessandro can spare some time for it. The example code in
Documentation/arm/tcm.txt can be used to see if the compile macros
and allocation pool are working.
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-nomadik/include/mach/memory.h |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..39cf2ba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -349,6 +349,7 @@ config ARCH_NOMADIK
 	select ARM_AMBA
 	select ARM_VIC
 	select CPU_ARM926T
+	select HAVE_TCM
 	select HAVE_CLK
 	select COMMON_CLKDEV
 	select GENERIC_TIME
diff --git a/arch/arm/mach-nomadik/include/mach/memory.h b/arch/arm/mach-nomadik/include/mach/memory.h
index 1e5689d..d2375de 100644
--- a/arch/arm/mach-nomadik/include/mach/memory.h
+++ b/arch/arm/mach-nomadik/include/mach/memory.h
@@ -25,4 +25,12 @@
  */
 #define PHYS_OFFSET	UL(0x00000000)
 
+/*
+ * TCM memory whereabouts
+ */
+#define ITCM_OFFSET	0xffff2000
+#define ITCM_END	0xffff3fff
+#define DTCM_OFFSET	0xffff4000
+#define DTCM_END	0xffff5fff
+
 #endif
-- 
1.6.2.5
