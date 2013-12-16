From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 16 Dec 2013 09:31:12 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Conditionally select MICREL_PHY
Message-ID: <1387153872-8387-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The koelsch board uses has an SH ethernet controller which uses a Micrel
phy. Select MICREL_PHY for koelsch if SH_ETH is enabled to make use of the
Micrel-specific phy driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index f01e878..670238a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -41,6 +41,7 @@ config MACH_GENMAI
 config MACH_KOELSCH
 	bool "Koelsch board"
 	depends on ARCH_R8A7791
+	select MICREL_PHY if SH_ETH
 
 config MACH_KZM9D
 	bool "KZM9D board"
@@ -269,11 +270,13 @@ config MACH_KOELSCH
 	bool "Koelsch board"
 	depends on ARCH_R8A7791
 	select USE_OF
+	select MICREL_PHY if SH_ETH
 
 config MACH_KOELSCH_REFERENCE
 	bool "Koelsch board - Reference Device Tree Implementation"
 	depends on ARCH_R8A7791
 	select USE_OF
+	select MICREL_PHY if SH_ETH
 	---help---
 	   Use reference implementation of Koelsch board support
 	   which makes use of device tree at the expense
-- 
1.8.4
