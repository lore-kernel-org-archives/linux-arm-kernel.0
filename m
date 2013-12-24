From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:07:00 +0900
Subject: [PATCH 08/13] ARM: shmobile: Add select MIGHT_HAVE_PCI for PCI-AHB
 bridge code
In-Reply-To: <cover.1387857168.git.horms+renesas@verge.net.au>
References: <cover.1387857168.git.horms+renesas@verge.net.au>
Message-ID: <7e429989b68533ee3896c96264a1cce99b95d218.1387857168.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

The PCI sub-system is not enabled by default on ARM and on certain
Renesas devices the build does not select it. This means that there
are configurations that do not allow the AHB-PCI bridge used for the
USB sub-systems to be built.

For the R8A7790, R8A7791 and EMEV-2 select MIGHT_HAVE_PCI to allow the
PCI drivers to be built. Also select MIGHT_HAVE_PCI for the multi-config
where there may be many Reneasas devices selected.

Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index aa9017b..8a1364e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -12,6 +12,7 @@ config ARCH_SHMOBILE_MULTI
 	select HAVE_SMP
 	select ARM_GIC
 	select MIGHT_HAVE_CACHE_L2X0
+	select MIGHT_HAVE_PCI
 	select NO_IOPORT
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
@@ -96,6 +97,7 @@ config ARCH_R8A7790
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
+	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 
@@ -104,6 +106,7 @@ config ARCH_R8A7791
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
+	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 
@@ -112,6 +115,7 @@ config ARCH_EMEV2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
+	select MIGHT_HAVE_PCI
 	select USE_OF
 	select AUTO_ZRELADDR
 
-- 
1.8.4
