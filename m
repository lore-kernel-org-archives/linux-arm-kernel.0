From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:57:47 +0900
Subject: [PATCH 1/7] ARM: shmobile: Use 64-bit dma_addr_t on r8a7790/r8a7791
In-Reply-To: <cover.1393400446.git.horms+renesas@verge.net.au>
References: <cover.1393400446.git.horms+renesas@verge.net.au>
Message-ID: <4a51856b42672cfcb7d6fbab22dcf2caba2be5ab.1393400446.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Some on-chip devices on r8a7790 and r8a7791 can do
bus mastering and access more than 32-bits of address
space. Select ARCH_DMA_ADDR_T_64BIT when LPAE is set
in case of multiplatform and legacy SoC support.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 3386406..0272cd7 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -13,6 +13,7 @@ config ARCH_SHMOBILE_MULTI
 	select ARM_GIC
 	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select NO_IOPORT
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
@@ -123,6 +124,7 @@ config ARCH_R8A7790
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select RENESAS_IRQC
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
@@ -132,6 +134,7 @@ config ARCH_R8A7791
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select RENESAS_IRQC
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
-- 
1.8.5.2
