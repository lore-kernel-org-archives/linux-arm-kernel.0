From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Dec 2013 16:37:29 +0100
Subject: [PATCH] ARM: sunxi: Select RESET_CONTROLLER
Message-ID: <1388417849-7728-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code selects ARCH_HAS_RESET_CONTROLLER, that enables the
RESET_CONTROLLER option by default, but doesn't select it, so a configuration
might unselect it, leading to compilation error.

Explictly select RESET_CONTROLLER so that we can't have this breakage anymore.

Reported-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 547004c..6278b12 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -11,6 +11,7 @@ config ARCH_SUNXI
 	select HAVE_SMP
 	select PINCTRL
 	select PINCTRL_SUNXI
+	select RESET_CONTROLLER
 	select SPARSE_IRQ
 	select SUN4I_TIMER
 	select SUN5I_HSTIMER
-- 
1.8.4.2
