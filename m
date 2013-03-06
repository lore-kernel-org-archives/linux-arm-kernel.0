From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 06 Mar 2013 11:39:25 +0100
Subject: [PATCH] ARM: EXYNOS: change HAVE_SAMSUNG_KEYPAD to KEYBOARD_SAMSUNG
Message-ID: <1362566365.16460.173.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6b5ab4f442e32f248b6fad29aafd1d5153f4dbd3 ("ARM: EXYNOS: Add
Exynos4 device tree enabled board file") added
	select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD

to the MACH_EXYNOS4_DT Kconfig entry. But there's no Kconfig symbol
HAVE_SAMSUNG_KEYPAD. Since this select statement depends on
INPUT_KEYBOARD this entry should select KEYBOARD_SAMSUNG instead.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Tested with "git grep" only.

1) Perhaps the fact that the symbol KEYBOARD_SAMSUNG enables a driver
called samsung-keypad caused confusion here. Anyhow, my choice for
KEYBOARD_SAMSUNG is only educated guesswork.

 arch/arm/mach-exynos/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 6c2bdc3..068aeb5 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -403,7 +403,7 @@ config MACH_EXYNOS4_DT
 	depends on ARCH_EXYNOS4
 	select ARM_AMBA
 	select CPU_EXYNOS4210
-	select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD
+	select KEYBOARD_SAMSUNG if INPUT_KEYBOARD
 	select PINCTRL
 	select PINCTRL_EXYNOS
 	select USE_OF
-- 
1.7.11.7
