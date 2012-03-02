From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:17 -0600
Subject: [PATCH v3 05/30] ARM: msm: clean-up mach/io.h
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move msm specifics in mach/io.h to respective msm_iomap-*.h headers.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/io.h             |    7 -------
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |    4 ++++
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h |    4 ++++
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |    4 ++++
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |    4 ++++
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/io.h b/arch/arm/mach-msm/include/mach/io.h
index c6ff9bb..1071f98 100644
--- a/arch/arm/mach-msm/include/mach/io.h
+++ b/arch/arm/mach-msm/include/mach/io.h
@@ -21,11 +21,4 @@
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)    (a)
 
-void msm_map_qsd8x50_io(void);
-void msm_map_msm7x30_io(void);
-void msm_map_msm8x60_io(void);
-void msm_map_msm8960_io(void);
-
-extern unsigned int msm_shared_ram_phys;
-
 #endif
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h b/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
index 198202c..f944fe6 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
@@ -100,4 +100,8 @@
 #define MSM_HSUSB_PHYS        0xA3600000
 #define MSM_HSUSB_SIZE        SZ_1K
 
+#ifndef __ASSEMBLY__
+extern void msm_map_msm7x30_io(void);
+#endif
+
 #endif
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8960.h b/arch/arm/mach-msm/include/mach/msm_iomap-8960.h
index 800b557..a1752c0 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8960.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8960.h
@@ -50,4 +50,8 @@
 #define MSM_DEBUG_UART_PHYS	0x16440000
 #endif
 
+#ifndef __ASSEMBLY__
+extern void msm_map_msm8960_io(void);
+#endif
+
 #endif
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
index 0faa894..da77cc1 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
@@ -122,4 +122,8 @@
 #define MSM_SDC4_PHYS          0xA0600000
 #define MSM_SDC4_SIZE          SZ_4K
 
+#ifndef __ASSEMBLY__
+extern void msm_map_qsd8x50_io(void);
+#endif
+
 #endif
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
index 54e12ca..5aed57d 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
@@ -67,4 +67,8 @@
 #define MSM_DEBUG_UART_PHYS	0x19C40000
 #endif
 
+#ifndef __ASSEMBLY__
+extern void msm_map_msm8x60_io(void);
+#endif
+
 #endif
-- 
1.7.5.4
