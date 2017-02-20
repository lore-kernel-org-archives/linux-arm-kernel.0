From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Mon, 20 Feb 2017 17:14:50 +0800
Subject: [PATCH v2 1/2] arm: hisi: add ARCH_MULTI_V5 support
In-Reply-To: <1487582091-24695-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1487582091-24695-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1487582091-24695-2-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pan Wen <wenpan@hisilicon.com>

Add support for some HiSilicon SoCs which depend on ARCH_MULTI_V5.

Signed-off-by: Pan Wen <wenpan@hisilicon.com>
---

This patch is same as the first version.

 arch/arm/mach-hisi/Kconfig | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index a3b091a..03d8379 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -1,12 +1,14 @@
 config ARCH_HISI
 	bool "Hisilicon SoC Support"
-	depends on ARCH_MULTI_V7
 	select ARM_AMBA
-	select ARM_GIC
+	select ARM_GIC if ARCH_MULTI_V7
+	select ARM_VIC if ARCH_MULTI_V5
 	select ARM_TIMER_SP804
 	select POWER_RESET
 	select POWER_RESET_HISI
 	select POWER_SUPPLY
+	select PINCTRL
+	select PINCTRL_SINGLE
 
 if ARCH_HISI
 
@@ -18,8 +20,6 @@ config ARCH_HI3xxx
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select PINCTRL
-	select PINCTRL_SINGLE
 	help
 	  Support for Hisilicon Hi36xx SoC family
 
@@ -48,8 +48,6 @@ config ARCH_HIX5HD2
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select PINCTRL
-	select PINCTRL_SINGLE
 	help
 	  Support for Hisilicon HIX5HD2 SoC family
 endmenu
-- 
1.9.1
