From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 14:31:11 +0100
Subject: [PATCH 5/5] ARM: integrator: select AMBA bus and GPIO block
In-Reply-To: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
References: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1390397471-6802-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrator/AP can be used with a logical module called
IM-PD1, which contains a few AMBA PrimeCell devices, one of which
is the PL061 GPIO controller. As the lines from this GPIO
controller are looped back to devices on the board itself and
provides resources back to it, we need to always have GPIO
and the PL061 driver available for other devices to work.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 46be99007529..b61e962ef992 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -30,7 +30,10 @@ config ARCH_CINTEGRATOR
 config INTEGRATOR_IMPD1
 	tristate "Include support for Integrator/IM-PD1"
 	depends on ARCH_INTEGRATOR_AP
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
 	select ARM_VIC
+	select GPIO_PL061 if GPIOLIB
 	help
 	  The IM-PD1 is an add-on logic module for the Integrator which
 	  allows ARM(R) Ltd PrimeCells to be developed and evaluated.
-- 
1.8.4.2
