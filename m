From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 31 Mar 2011 09:08:14 +0200
Subject: [PATCH] mach-ux500: add HREFv60 Kconfig option
Message-ID: <1301555294-15474-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This is necessary to have any use of the HREFv60 code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 1e34d66..969e751 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -18,7 +18,7 @@ config UX500_SOC_DB8500
 
 endmenu
 
-menu "Ux500 target platform"
+menu "Ux500 target platform (boards)"
 
 config MACH_U8500
 	bool "U8500 Development platform"
@@ -27,6 +27,12 @@ config MACH_U8500
 	help
 	  Include support for the mop500 development platform.
 
+config MACH_HREFV60
+       bool "U85000 Development platform, HREFv60 version"
+       depends on UX500_SOC_DB8500
+       help
+         Include support for the HREFv60 new development platform.
+
 config MACH_U8500_SNOWBALL
 	bool "U8500 Snowball platform"
 	depends on UX500_SOC_DB8500
-- 
1.7.3.2
