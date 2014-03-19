From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:40 +0100
Subject: [PATCH 43/62] ARM: integrator: only select pl01x if TTY is enabled
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-44-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building the integrator platform without TTY support currently
results in a build failure because we always turn on the
pl010 or pl011 drivers. Changing this to a conditional 'select'
statement enables us to build more random configurations, although
it should have little impact for practical configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 6e8b0e1..ba43321 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -6,8 +6,8 @@ config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
 	select CLKSRC_MMIO
 	select MIGHT_HAVE_PCI
-	select SERIAL_AMBA_PL010
-	select SERIAL_AMBA_PL010_CONSOLE
+	select SERIAL_AMBA_PL010 if TTY
+	select SERIAL_AMBA_PL010_CONSOLE if TTY
 	select SOC_BUS
 	help
 	  Include support for the ARM(R) Integrator/AP and
@@ -18,8 +18,8 @@ config ARCH_INTEGRATOR_CP
 	select ARCH_CINTEGRATOR
 	select ARM_TIMER_SP804
 	select PLAT_VERSATILE_CLCD
-	select SERIAL_AMBA_PL011
-	select SERIAL_AMBA_PL011_CONSOLE
+	select SERIAL_AMBA_PL011 if TTY
+	select SERIAL_AMBA_PL011_CONSOLE if TTY
 	select SOC_BUS
 	help
 	  Include support for the ARM(R) Integrator CP platform.
-- 
1.8.3.2
