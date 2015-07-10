From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Jul 2015 15:45:47 -0700
Subject: [PATCH 7/7] ARM: OMAP2+: Include clk.h
In-Reply-To: <1436568347-24554-1-git-send-email-sboyd@codeaurora.org>
References: <1436568347-24554-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1436568347-24554-8-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These files use the consumer API, so include clk.h explicitly.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Please ack so this can be routed through clk-tree. Otherwise
when clk.h is removed from clk-provider.h these files will
fail to compile.

 arch/arm/mach-omap2/clock.c      | 1 +
 arch/arm/mach-omap2/omap_hwmod.c | 1 +
 arch/arm/mach-omap2/pm24xx.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index a699d7169307..f664dc664ded 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d78c12e7cb5e..de43e4c9a865 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -130,6 +130,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index b1aad7e1426c..2a1a4180d5d0 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -25,6 +25,7 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/irq.h>
 #include <linux/time.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
