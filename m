From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 18:47:23 +0200
Subject: [PATCH 3/8] ARM i.MX: remove SoC defines around header includes
In-Reply-To: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305823648-2428-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All soc specific header have proper namespace now and thus can
be included at once.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/hardware.h |   28 +++++-----------------------
 1 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 67d3e2b..a8bfd56 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -97,35 +97,17 @@
 
 #include <mach/mxc.h>
 
-#ifdef CONFIG_ARCH_MX5
 #include <mach/mx50.h>
 #include <mach/mx51.h>
 #include <mach/mx53.h>
-#endif
-
-#ifdef CONFIG_ARCH_MX3
 #include <mach/mx3x.h>
 #include <mach/mx31.h>
 #include <mach/mx35.h>
-#endif
-
-#ifdef CONFIG_ARCH_MX2
-# include <mach/mx2x.h>
-# ifdef CONFIG_MACH_MX21
-#  include <mach/mx21.h>
-# endif
-# ifdef CONFIG_MACH_MX27
-#  include <mach/mx27.h>
-# endif
-#endif
-
-#ifdef CONFIG_ARCH_MX1
-# include <mach/mx1.h>
-#endif
-
-#ifdef CONFIG_ARCH_MX25
-# include <mach/mx25.h>
-#endif
+#include <mach/mx2x.h>
+#include <mach/mx21.h>
+#include <mach/mx27.h>
+#include <mach/mx1.h>
+#include <mach/mx25.h>
 
 #define imx_map_entry(soc, name, _type)	{				\
 	.virtual = soc ## _IO_P2V(soc ## _ ## name ## _BASE_ADDR),	\
-- 
1.7.4.1
