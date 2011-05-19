From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 18:47:26 +0200
Subject: [PATCH 6/8] ARM i.MX mxc.h: use CONFIG_SOC_* instead of CONFIG_ARCH_*
In-Reply-To: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305823648-2428-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_ARCH_* are deprecated, so remove one user.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mxc.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 4ac53ce..0987923 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -68,7 +68,7 @@
 extern unsigned int __mxc_cpu_type;
 #endif
 
-#ifdef CONFIG_ARCH_MX1
+#ifdef CONFIG_SOC_IMX1
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
 #  define mxc_cpu_type __mxc_cpu_type
@@ -80,7 +80,7 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx1()		(0)
 #endif
 
-#ifdef CONFIG_MACH_MX21
+#ifdef CONFIG_SOC_IMX21
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
 #  define mxc_cpu_type __mxc_cpu_type
@@ -92,7 +92,7 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx21()		(0)
 #endif
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
 #  define mxc_cpu_type __mxc_cpu_type
@@ -104,7 +104,7 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx25()		(0)
 #endif
 
-#ifdef CONFIG_MACH_MX27
+#ifdef CONFIG_SOC_IMX27
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
 #  define mxc_cpu_type __mxc_cpu_type
-- 
1.7.4.1
