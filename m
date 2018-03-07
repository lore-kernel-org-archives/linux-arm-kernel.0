From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  7 Mar 2018 14:58:19 +0100
Subject: [PATCH 2/3] ARM: ux500: Cut down Kconfig options
In-Reply-To: <20180307135820.16221-1-linus.walleij@linaro.org>
References: <20180307135820.16221-1-linus.walleij@linaro.org>
Message-ID: <20180307135820.16221-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These systems are not plentiful and do not have any
strict memory constraints. Cut down the configurability
and select what is needed for all of them so they simply boot,
keeping only the UX500_SOC_DB8500 symbol which is used
elsewhere in the kernel for now, but default it to y.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig | 50 ++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 7289ec8404c9..c1086ebe0050 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -9,61 +9,33 @@ menuconfig ARCH_U8500
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
 	select CACHE_L2X0
+	select CLKSRC_DBX500_PRCMU
 	select CLKSRC_NOMADIK_MTU
 	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
+	select I2C
+	select I2C_NOMADIK
+	select MFD_DB8500_PRCMU
 	select PINCTRL
+	select PINCTRL_AB8500
+	select PINCTRL_AB8505
 	select PINCTRL_ABX500
+	select PINCTRL_DB8500
 	select PINCTRL_NOMADIK
 	select PL310_ERRATA_753970 if CACHE_L2X0
-	help
-	  Support for ST-Ericsson's Ux500 architecture
-
-if ARCH_U8500
-
-config UX500_SOC_DB8500
-	bool
-	select MFD_DB8500_PRCMU
-	select PINCTRL_DB8500
-	select PINCTRL_AB8500
-	select PINCTRL_AB8505
-	select REGULATOR
-	select REGULATOR_DB8500_PRCMU
-	select CLKSRC_DBX500_PRCMU
 	select PM_GENERIC_DOMAINS if PM
-
-config MACH_MOP500
-	bool "U8500 Development platform, MOP500 versions"
-	select I2C
-	select I2C_NOMADIK
 	select REGULATOR
+	select REGULATOR_DB8500_PRCMU
 	select REGULATOR_FIXED_VOLTAGE
 	select SOC_BUS
-	select UX500_SOC_DB8500
 	help
-	  Include support for the MOP500 development platform.
-
-config MACH_HREFV60
-	bool "U8500 Development platform, HREFv60 version"
-	select MACH_MOP500
-	help
-	  Include support for the HREFv60 new development platform.
-	  Includes HREFv70, v71 etc.
+	  Support for ST-Ericsson's Ux500 architecture
 
-config MACH_SNOWBALL
-	bool "U8500 Snowball platform"
-	select MACH_MOP500
-	help
-	  Include support for the snowball development platform.
+if ARCH_U8500
 
-config UX500_AUTO_PLATFORM
+config UX500_SOC_DB8500
 	def_bool y
-	select MACH_MOP500
-	help
-	  At least one platform needs to be selected in order to build
-	  a working kernel. If everything else is disabled, this
-	  automatically enables MACH_MOP500.
 
 config UX500_DEBUG_UART
 	int "Ux500 UART to use for low-level debug"
-- 
2.14.3
