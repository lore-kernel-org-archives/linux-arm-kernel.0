From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:56 +0100
Subject: [PATCH 59/62] ARM: shmobile: ak4642 needs i2c support
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-60-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot select SND_SOC_AK4642 if the I2C core layer
is disabled. Making the select statement conditional
ensures that we can build all configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh at vger.kernel.org
---
 arch/arm/mach-shmobile/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 5249ff0..6e3904e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -170,7 +170,7 @@ config MACH_MACKEREL
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SMSC_PHY if SMSC911X
-	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD && I2C=y
 	select USE_OF
 
 config MACH_ARMADILLO800EVA
@@ -179,7 +179,7 @@ config MACH_ARMADILLO800EVA
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SMSC_PHY if SH_ETH
-	select SND_SOC_WM8978 if SND_SIMPLE_CARD
+	select SND_SOC_WM8978 if SND_SIMPLE_CARD && I2C=y
 	select USE_OF
 
 config MACH_ARMADILLO800EVA_REFERENCE
@@ -188,7 +188,7 @@ config MACH_ARMADILLO800EVA_REFERENCE
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SMSC_PHY if SH_ETH
-	select SND_SOC_WM8978 if SND_SIMPLE_CARD
+	select SND_SOC_WM8978 if SND_SIMPLE_CARD && I2C=y
 	select USE_OF
 	---help---
 	   Use reference implementation of Aramdillo800 EVA board support
@@ -204,7 +204,7 @@ config MACH_BOCKW
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select RENESAS_INTC_IRQPIN
 	select SND_SOC_AK4554 if SND_SIMPLE_CARD
-	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD && I2C=y
 	select USE_OF
 
 config MACH_BOCKW_REFERENCE
@@ -277,7 +277,7 @@ config MACH_KZM9G
 	select ARCH_HAS_OPP
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD && I2C=y
 	select USE_OF
 
 config MACH_KZM9G_REFERENCE
@@ -285,7 +285,7 @@ config MACH_KZM9G_REFERENCE
 	depends on ARCH_SH73A0
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD && I2C=y
 	select USE_OF
 	---help---
 	   Use reference implementation of KZM-A9-GT board support
-- 
1.8.3.2
