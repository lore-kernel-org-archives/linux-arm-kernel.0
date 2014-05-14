From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 14 May 2014 21:30:14 +0400
Subject: [PATCH 2/2] ARM: i.MX: Select HAVE_IMX_SRC for i.MX5 globally
In-Reply-To: <1400088614-27280-1-git-send-email-shc_work@mail.ru>
References: <1400088614-27280-1-git-send-email-shc_work@mail.ru>
Message-ID: <1400088614-27280-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No reason to choose a symbol HAVE_IMX_SRC separately for each supported
i.MX5 CPU, this patch selects this symbol globally for i.MX5.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29433e7..e956f4b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -127,11 +127,11 @@ config SOC_IMX5
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARCH_MXC_IOMUX_V3
+	select HAVE_IMX_SRC
 	select MXC_TZIC
 
 config	SOC_IMX51
 	bool
-	select HAVE_IMX_SRC
 	select PINCTRL_IMX51
 	select SOC_IMX5
 
@@ -749,7 +749,6 @@ comment "Device tree only"
 config SOC_IMX50
 	bool "i.MX50 support"
 	depends on ARCH_MULTI_V7
-	select HAVE_IMX_SRC
 	select PINCTRL_IMX50
 	select SOC_IMX5
 	help
@@ -758,7 +757,6 @@ config SOC_IMX50
 config SOC_IMX53
 	bool "i.MX53 support"
 	depends on ARCH_MULTI_V7
-	select HAVE_IMX_SRC
 	select PINCTRL_IMX53
 	select SOC_IMX5
 	help
-- 
1.8.3.2
