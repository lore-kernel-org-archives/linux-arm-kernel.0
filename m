From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  4 Jan 2013 14:17:15 +0000
Subject: [PATCH v3 1/7] arm: Move sp810.h to include/linux/amba/
In-Reply-To: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
References: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1357309041-6192-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since it is now used by code under drivers/clk/ it makes sense for this
file to be in a more generic location. This is required for building
vexpress support on arm64.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Pawel Moll <pawel.moll@arm.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/plat-spear/restart.c                                 | 2 +-
 drivers/clk/versatile/clk-vexpress.c                          | 3 +--
 {arch/arm/include/asm/hardware => include/linux/amba}/sp810.h | 0
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename {arch/arm/include/asm/hardware => include/linux/amba}/sp810.h (100%)

diff --git a/arch/arm/plat-spear/restart.c b/arch/arm/plat-spear/restart.c
index 4f99011..7d4616d 100644
--- a/arch/arm/plat-spear/restart.c
+++ b/arch/arm/plat-spear/restart.c
@@ -11,8 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 #include <linux/io.h>
+#include <linux/amba/sp810.h>
 #include <asm/system_misc.h>
-#include <asm/hardware/sp810.h>
 #include <mach/spear.h>
 #include <mach/generic.h>
 
diff --git a/drivers/clk/versatile/clk-vexpress.c b/drivers/clk/versatile/clk-vexpress.c
index c742ac7..4f83ff9 100644
--- a/drivers/clk/versatile/clk-vexpress.c
+++ b/drivers/clk/versatile/clk-vexpress.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2012 ARM Limited
  */
 
+#include <linux/amba/sp810.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
@@ -18,8 +19,6 @@
 #include <linux/of_address.h>
 #include <linux/vexpress.h>
 
-#include <asm/hardware/sp810.h>
-
 static struct clk *vexpress_sp810_timerclken[4];
 static DEFINE_SPINLOCK(vexpress_sp810_lock);
 
diff --git a/arch/arm/include/asm/hardware/sp810.h b/include/linux/amba/sp810.h
similarity index 100%
rename from arch/arm/include/asm/hardware/sp810.h
rename to include/linux/amba/sp810.h
