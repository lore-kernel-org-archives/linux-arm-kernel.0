From: eric.y.miao@gmail.com (eric.y.miao at gmail.com)
Date: Mon, 9 Aug 2010 09:50:04 +0800
Subject: [PATCH] fix carelessly written Kconfig select statement
Message-ID: <AANLkTinAn_o7+AQzEk7V1vHzCFPPn6AVv=gMqCq7DDdH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any one found this?

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 232f0c7..684c1a1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1184,8 +1184,8 @@ config LOCAL_TIMERS
 		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
 		ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_TEGRA)
 	default y
-	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \\
-		ARCH_U8500 || ARCH_TEGRA
+	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \
+		ARCH_U8500 || ARCH_TEGRA)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
