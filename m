From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:19:05 +0900
Subject: [PATCH 13/21] ARM: shmobile: armadillo800eva: Conditionally select
 SMSC_PHY
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <6a517b114d007a35fc264ef16b09db35548f0290.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armadillo800eva board uses has an SH ethernet controller which uses an
SMSC phy. Select SMSC_PHY for koelsch if SH_ETH is enabled to make use of the
SMSC-specific phy driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2673f68..b624b5a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -184,6 +184,7 @@ config MACH_ARMADILLO800EVA
 	depends on ARCH_R8A7740
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SH_ETH
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 	select USE_OF
 
@@ -192,6 +193,7 @@ config MACH_ARMADILLO800EVA_REFERENCE
 	depends on ARCH_R8A7740
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SH_ETH
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 	select USE_OF
 	---help---
-- 
1.8.5.2
