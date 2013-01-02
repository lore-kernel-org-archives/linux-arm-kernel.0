From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:43 -0800
Subject: [PATCH 06/26] ARM: S5PV210: move regs-sys.h into setup-usb-phy.c file
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The <mach/regs-sys.h> can be moved into mach-s5pv210/setup-usb-phy.c
file.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/regs-sys.h |   15 ---------------
 arch/arm/mach-s5pv210/setup-usb-phy.c         |    7 ++++++-
 2 files changed, 6 insertions(+), 16 deletions(-)
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/regs-sys.h

diff --git a/arch/arm/mach-s5pv210/include/mach/regs-sys.h b/arch/arm/mach-s5pv210/include/mach/regs-sys.h
deleted file mode 100644
index cccb1ed..0000000
--- a/arch/arm/mach-s5pv210/include/mach/regs-sys.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* arch/arm/mach-s5pv210/include/mach/regs-sys.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5PV210 - System registers definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S5PV210_USB_PHY_CON	(S3C_VA_SYS + 0xE80C)
-#define S5PV210_USB_PHY0_EN	(1 << 0)
-#define S5PV210_USB_PHY1_EN	(1 << 1)
diff --git a/arch/arm/mach-s5pv210/setup-usb-phy.c b/arch/arm/mach-s5pv210/setup-usb-phy.c
index be39cf4..356a090 100644
--- a/arch/arm/mach-s5pv210/setup-usb-phy.c
+++ b/arch/arm/mach-s5pv210/setup-usb-phy.c
@@ -12,12 +12,17 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+
 #include <mach/map.h>
-#include <mach/regs-sys.h>
+
 #include <plat/cpu.h>
 #include <plat/regs-usb-hsotg-phy.h>
 #include <plat/usb-phy.h>
 
+#define S5PV210_USB_PHY_CON	(S3C_VA_SYS + 0xE80C)
+#define S5PV210_USB_PHY0_EN	(1 << 0)
+#define S5PV210_USB_PHY1_EN	(1 << 1)
+
 static int s5pv210_usb_otgphy_init(struct platform_device *pdev)
 {
 	struct clk *xusbxti;
-- 
1.7.10.4
