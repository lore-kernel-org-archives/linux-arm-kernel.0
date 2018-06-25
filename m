From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 25 Jun 2018 12:34:44 +0900
Subject: [PATCH 1/2] ARM: uniphier: select RESET_CONTROLLER
Message-ID: <1529897685-15029-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UniPhier platform highly relies on the reset controller.
Select RESET_CONTROLLER to enable it forcibly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
index 779235a..e661d26 100644
--- a/arch/arm/mach-uniphier/Kconfig
+++ b/arch/arm/mach-uniphier/Kconfig
@@ -9,6 +9,7 @@ config ARCH_UNIPHIER
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
+	select RESET_CONTROLLER
 	help
 	  Support for UniPhier SoC family developed by Socionext Inc.
 	  (formerly, System LSI Business Division of Panasonic Corporation)
-- 
2.7.4
