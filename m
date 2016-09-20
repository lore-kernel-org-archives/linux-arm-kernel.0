From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 20 Sep 2016 13:43:19 +0900
Subject: [PATCH] ARM: uniphier: select ARCH_HAS_RESET_CONTROLLER
Message-ID: <1474346599-29925-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UniPhier reset driver (drivers/reset/reset-uniphier.c) has been
merged.  Select ARCH_HAS_RESET_CONTROLLER from the SoC Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Philipp,

IIRC, you mentioned that you were planning to consolidate the double
gurad by CONFIG_RESET_CONTROLLER and CONFIG_ARCH_HAS_RESET_CONTROLLER.

I have not seen it in the ML, so I am sending this.

Please let me know if you have some updates.


 arch/arm/mach-uniphier/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
index 82dddee..3930fbb 100644
--- a/arch/arm/mach-uniphier/Kconfig
+++ b/arch/arm/mach-uniphier/Kconfig
@@ -1,6 +1,7 @@
 config ARCH_UNIPHIER
 	bool "Socionext UniPhier SoCs"
 	depends on ARCH_MULTI_V7
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_AMBA
 	select ARM_GLOBAL_TIMER
 	select ARM_GIC
-- 
1.9.1
