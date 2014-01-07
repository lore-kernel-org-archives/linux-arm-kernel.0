From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  7 Jan 2014 17:48:06 +0900
Subject: [PATCH 6/8] ARM: shmobile: kzm9g: Conditionally select SMSC_PHY
In-Reply-To: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
References: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1389084488-25984-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kzm9g board uses has an SMSC911X ethernet controller which uses an
SMSC phy. Select SMSC_PHY for kzm9g if SMSC911X is enabled to make use of the
SMSC-specific phy driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index e88d2e5..2ccd597 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -285,6 +285,7 @@ config MACH_KZM9G
 	select ARCH_HAS_OPP
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SMSC911X
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select USE_OF
 
@@ -293,6 +294,7 @@ config MACH_KZM9G_REFERENCE
 	depends on ARCH_SH73A0
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SMSC911X
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select USE_OF
 	---help---
-- 
1.8.4
