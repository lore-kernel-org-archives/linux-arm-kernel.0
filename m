From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Apr 2014 17:04:34 +0200
Subject: [PATCH 3/5] ARM: sunxi: Select restart drivers
In-Reply-To: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398265476-29373-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure we have the restart hooks in the kernel by selecting them in Kconfig.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b57d7d53b9d3..5fe80cc9b524 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -9,6 +9,10 @@ config ARCH_SUNXI
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL
 	select PINCTRL_SUNXI
+	select POWER_RESET
+	select POWER_RESET_SUN6I
+	select POWER_SUPPLY
 	select RESET_CONTROLLER
 	select SUN4I_TIMER
 	select SUN5I_HSTIMER
+	select SUNXI_WATCHDOG
-- 
1.9.1
