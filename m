From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Dec 2011 01:42:36 +0100
Subject: [PATCH 2/2] ARM: integrator: explicitly select the serial drivers
Message-ID: <1324341756-20814-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The defconfig for the Integrator only include the serial drivers
for the PL010 as found in the Integrator/AP, to make sure we
don't loose the serial console we simply select both PL010 and
PL011 drivers from the Integrator Kconfig entries so they are
always included when applicable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index dfd18f3..350e266 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -6,6 +6,8 @@ config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
 	select CLKSRC_MMIO
 	select MIGHT_HAVE_PCI
+	select SERIAL_AMBA_PL010
+	select SERIAL_AMBA_PL010_CONSOLE
 	help
 	  Include support for the ARM(R) Integrator/AP and
 	  Integrator/PP2 platforms.
@@ -15,6 +17,8 @@ config ARCH_INTEGRATOR_CP
 	select ARCH_CINTEGRATOR
 	select ARM_TIMER_SP804
 	select PLAT_VERSATILE_CLCD
+	select SERIAL_AMBA_PL011
+	select SERIAL_AMBA_PL011_CONSOLE
 	help
 	  Include support for the ARM(R) Integrator CP platform.
 
-- 
1.7.6.4
