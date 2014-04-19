From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 19 Apr 2014 09:04:03 +0400
Subject: [PATCH] ARM: i.MX: Remove #ifdef CONFIG_OF
Message-ID: <1397883843-6620-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_OF is always selected for i.MX.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx27.c | 2 --
 arch/arm/mach-imx/clk-imx31.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index d2da890..0db0b4f 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -296,7 +296,6 @@ int __init mx27_clocks_init(unsigned long fref)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 int __init mx27_clocks_init_dt(void)
 {
 	struct device_node *np;
@@ -312,4 +311,3 @@ int __init mx27_clocks_init_dt(void)
 
 	return mx27_clocks_init(fref);
 }
-#endif
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index b5b65f3..4a9de08 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -191,7 +191,6 @@ int __init mx31_clocks_init(unsigned long fref)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 int __init mx31_clocks_init_dt(void)
 {
 	struct device_node *np;
@@ -207,4 +206,3 @@ int __init mx31_clocks_init_dt(void)
 
 	return mx31_clocks_init(fref);
 }
-#endif
-- 
1.8.3.2
