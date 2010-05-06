From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:07 -0700
Subject: [PATCH 16/34] Davinci: tnetv107x cpu types
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-17-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

Added tnetv107x cpu type definitions and cpu identification macros.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/cputype.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/cputype.h b/arch/arm/mach-davinci/include/mach/cputype.h
index 189b1ff..cea6b89 100644
--- a/arch/arm/mach-davinci/include/mach/cputype.h
+++ b/arch/arm/mach-davinci/include/mach/cputype.h
@@ -33,6 +33,7 @@ struct davinci_id {
 #define	DAVINCI_CPU_ID_DM365		0x03650000
 #define	DAVINCI_CPU_ID_DA830		0x08300000
 #define	DAVINCI_CPU_ID_DA850		0x08500000
+#define	DAVINCI_CPU_ID_TNETV107X	0x0b8a0000
 
 #define IS_DAVINCI_CPU(type, id)					\
 static inline int is_davinci_ ##type(void)				\
@@ -46,6 +47,7 @@ IS_DAVINCI_CPU(dm355, DAVINCI_CPU_ID_DM355)
 IS_DAVINCI_CPU(dm365, DAVINCI_CPU_ID_DM365)
 IS_DAVINCI_CPU(da830, DAVINCI_CPU_ID_DA830)
 IS_DAVINCI_CPU(da850, DAVINCI_CPU_ID_DA850)
+IS_DAVINCI_CPU(tnetv107x, DAVINCI_CPU_ID_TNETV107X)
 
 #ifdef CONFIG_ARCH_DAVINCI_DM644x
 #define cpu_is_davinci_dm644x() is_davinci_dm644x()
@@ -83,4 +85,10 @@ IS_DAVINCI_CPU(da850, DAVINCI_CPU_ID_DA850)
 #define cpu_is_davinci_da850() 0
 #endif
 
+#ifdef CONFIG_ARCH_DAVINCI_TNETV107X
+#define cpu_is_davinci_tnetv107x() is_davinci_tnetv107x()
+#else
+#define cpu_is_davinci_tnetv107x() 0
+#endif
+
 #endif
-- 
1.7.0.2
