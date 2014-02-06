From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:18:57 +0900
Subject: [PATCH 05/21] ARM: shmobile: koelsch: Conditionally select MICREL_PHY
 for Multiplatform
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <aefe88ba044bdcd91bc0cd1e75ab2dc524ed5107.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The koelsch board uses has an SH ethernet controller which uses a Micrel
phy. Select MICREL_PHY for koelsch if SH_ETH is enabled to make use of the
Micrel-specific phy driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a127252..958ccf3d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -45,6 +45,7 @@ config MACH_GENMAI
 config MACH_KOELSCH
 	bool "Koelsch board"
 	depends on ARCH_R8A7791
+	select MICREL_PHY if SH_ETH
 
 config MACH_KZM9D
 	bool "KZM9D board"
-- 
1.8.5.2
