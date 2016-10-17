From: wenpan@hisilicon.com (Pan Wen)
Date: Mon, 17 Oct 2016 20:07:03 +0800
Subject: [PATCH 1/3] arm: hisi: add ARCH_MULTI_V5 support
In-Reply-To: <20161017120705.3726-1-wenpan@hisilicon.com>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
Message-ID: <20161017120705.3726-2-wenpan@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for some HiSilicon SoCs which depend on ARCH_MULTI_V5.

Signed-off-by: Pan Wen <wenpan@hisilicon.com>
---
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
2.9.3
