From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Sep 2013 15:08:52 +0200
Subject: [PATCH] ARM: u300: hide submenus
Message-ID: <1379509732-25228-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now the U300 submenus are showcased for everyone even if
we're not on v5 multiplatforms. Hide this in the multiplatform
configuration properly.

Cc: arm at kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: I don't know if you feel this is a fix or not,
feel free to apply it on your fixes if you like, else I'll carry
it for a U300 pull request later.
---
 arch/arm/mach-u300/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index a85adcd..a165986 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -1,7 +1,3 @@
-menu "ST-Ericsson AB U300/U335 Platform"
-
-comment "ST-Ericsson Mobile Platform Products"
-
 config ARCH_U300
 	bool "ST-Ericsson U300 Series" if ARCH_MULTI_V5
 	depends on MMU
@@ -25,7 +21,9 @@ config ARCH_U300
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
 
-comment "ST-Ericsson U300/U335 Feature Selections"
+if ARCH_U300
+
+menu "ST-Ericsson AB U300/U335 Platform"
 
 config MACH_U300
 	depends on ARCH_U300
@@ -53,3 +51,5 @@ config MACH_U300_SPIDUMMY
 		SPI framework and ARM PL022 support.
 
 endmenu
+
+endif
-- 
1.8.3.1
