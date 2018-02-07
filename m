From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  7 Feb 2018 14:45:52 +0100
Subject: [PATCH 6/7] ARM: davinci: select generic power domains for DaVinci in
 DT mode
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
Message-ID: <20180207134553.13510-7-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Automatically select the genpd framework in DT mode.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index da8a039d65f9..cb5dd239e375 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -60,6 +60,7 @@ config MACH_DA8XX_DT
 	depends on ARCH_DAVINCI_DA850
 	select PINCTRL
 	select TIMER_OF
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  Say y here to include support for TI DaVinci DA850 based using
 	  Flattened Device Tree. More information at Documentation/devicetree
-- 
2.16.1
