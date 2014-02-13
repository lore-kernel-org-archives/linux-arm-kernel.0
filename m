From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:03:54 +0900
Subject: [PATCH 07/11] Revert "ARM: shmobile: marzen: Conditionally select
 SMSC_PHY"
In-Reply-To: <cover.1392276547.git.horms+renesas@verge.net.au>
References: <cover.1392276547.git.horms+renesas@verge.net.au>
Message-ID: <c73c7ff8d5b1f4ee0bb9cd7c57c37782954b2246.1392276547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 317af6612ee29dfcb5ae04df9c58e9f79fc8d4ff.

This seems to prevent the board from booting now that the tree has been
rebased on v3.14-rc1.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index bcbd74c..c431114 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -250,7 +250,6 @@ config MACH_MARZEN
 	depends on ARCH_R8A7779
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select SMSC_PHY if SMSC911X
 	select USE_OF
 
 config MACH_MARZEN_REFERENCE
@@ -258,7 +257,6 @@ config MACH_MARZEN_REFERENCE
 	depends on ARCH_R8A7779
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select SMSC_PHY if SMSC911X
 	select USE_OF
 	---help---
 	   Use reference implementation of Marzen board support
-- 
1.8.5.2
