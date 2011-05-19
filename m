From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 18:47:21 +0200
Subject: [PATCH 1/8] ARM i.MX: fix last user of iomux.h and remove it
In-Reply-To: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305823648-2428-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    2 +-
 arch/arm/plat-mxc/include/mach/iomux.h      |   26 --------------------------
 2 files changed, 1 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/iomux.h

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 7ae43b1..6864496 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -34,7 +34,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
-#include <mach/iomux.h>
+#include <mach/iomux-mx27.h>
 
 #include "devices-imx27.h"
 
diff --git a/arch/arm/plat-mxc/include/mach/iomux.h b/arch/arm/plat-mxc/include/mach/iomux.h
deleted file mode 100644
index 3d226d7..0000000
--- a/arch/arm/plat-mxc/include/mach/iomux.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * Copyright (C) 2010 Uwe Kleine-Koenig, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __MACH_IOMUX_H__
-#define __MACH_IOMUX_H__
-
-/* This file will go away, please include mach/iomux-mx... directly */
-
-#ifdef CONFIG_ARCH_MX1
-#include <mach/iomux-mx1.h>
-#endif
-#ifdef CONFIG_ARCH_MX2
-#include <mach/iomux-mx2x.h>
-#ifdef CONFIG_MACH_MX21
-#include <mach/iomux-mx21.h>
-#endif
-#ifdef CONFIG_MACH_MX27
-#include <mach/iomux-mx27.h>
-#endif
-#endif
-
-#endif /* __MACH_IOMUX_H__ */
-- 
1.7.4.1
