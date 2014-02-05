From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Feb 2014 14:36:28 +0900
Subject: [PATCH] ARM: shmobile: Use 64-bit dma_addr_t on r8a7790/r8a7791
Message-ID: <20140205053628.29078.92360.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Some on-chip devices on r8a7790 and r8a7791 can do
bus mastering and access more than 32-bits of address
space. Select ARCH_DMA_ADDR_T_64BIT when LPAE is set
in case of multiplatform and legacy SoC support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-02-04 17:04:53.000000000 +0900
@@ -13,6 +13,7 @@ config ARCH_SHMOBILE_MULTI
 	select ARM_GIC
 	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select NO_IOPORT
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
@@ -126,6 +127,7 @@ config ARCH_R8A7790
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select RENESAS_IRQC
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
@@ -135,6 +137,7 @@ config ARCH_R8A7791
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select RENESAS_IRQC
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
