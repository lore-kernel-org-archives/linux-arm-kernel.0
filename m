From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 23 Jan 2013 17:37:46 +0100
Subject: [PATCH v3 3/8] ARM: shmobile: simplify armadillo800eva and kzm9g
 Kconfig dependencies
In-Reply-To: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
References: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1358959071-2873-4-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference kernel configurations for armadillo800eva and kzm9g boards do not
have to depend on their respective "legacy" configurations, doing device
instantiation in .c, they can be configured and built independently.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/Kconfig |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 5f61e8f..927eecc 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -106,7 +106,11 @@ config MACH_ARMADILLO800EVA
 
 config MACH_ARMADILLO800EVA_REFERENCE
 	bool "Armadillo-800 EVA board - Reference Device Tree Implementation"
-	depends on MACH_ARMADILLO800EVA
+	depends on ARCH_R8A7740
+	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SND_SOC_WM8978 if SND_SIMPLE_CARD
+	select USE_OF
 	---help---
 	  Use reference implementation of Aramdillo800 EVA board support
 	  which makes a greater use of device tree at the expense
@@ -136,7 +140,11 @@ config MACH_KZM9G
 
 config MACH_KZM9G_REFERENCE
 	bool "KZM-A9-GT board - Reference Device Tree Implementation"
-	depends on MACH_KZM9G
+	depends on ARCH_SH73A0
+	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select USE_OF
 	---help---
 	   Use reference implementation of KZM-A9-GT board support
 	   which makes as greater use of device tree at the expense
-- 
1.7.2.5
