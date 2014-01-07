From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  7 Jan 2014 17:48:08 +0900
Subject: [PATCH 8/8] ARM: shmobile: marzen: Conditionally select SMSC_PHY
In-Reply-To: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
References: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1389084488-25984-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The marzen board uses has an SMSC911X ethernet controller which uses an
SMSC phy. Select SMSC_PHY for marzen if SMSC911X is enabled to make use of the
SMSC-specific phy driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index d745b1f..8011329 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -252,6 +252,7 @@ config MACH_MARZEN
 	depends on ARCH_R8A7779
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SMSC911X
 	select USE_OF
 
 config MACH_MARZEN_REFERENCE
@@ -259,6 +260,7 @@ config MACH_MARZEN_REFERENCE
 	depends on ARCH_R8A7779
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SMSC911X
 	select USE_OF
 	---help---
 	   Use reference implementation of Marzen board support
-- 
1.8.4
