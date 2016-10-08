From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat,  8 Oct 2016 11:25:34 +0900
Subject: [PATCH] arm64: uniphier: select ARCH_HAS_RESET_CONTROLLER
Message-ID: <1475893534-12198-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UniPhier reset driver (drivers/reset/reset-uniphier.c) has been
merged.  Select ARCH_HAS_RESET_CONTROLLER from the SoC Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This is a counter-part of the following ARM-32bit variant:
https://patchwork.kernel.org/patch/9341021/

As discussed with Philipp, we go ARCH_HAS_RESET_CONTROLLER for now.


 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b6b3657..d4f5f5c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -178,6 +178,7 @@ config ARCH_THUNDER
 
 config ARCH_UNIPHIER
 	bool "Socionext UniPhier SoC Family"
+	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
 	help
 	  This enables support for Socionext UniPhier SoC family.
-- 
1.9.1
