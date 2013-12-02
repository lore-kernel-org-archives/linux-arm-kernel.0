From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  2 Dec 2013 11:19:10 +0900
Subject: [PATCH 08/28] ARM: shmobile: Select GPIO in case of the r7s72100 SoC
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
Message-ID: <bebd60f91cb43b03707d90f88a7470d2efd83776.1385950394.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r7s72100 contains GPIO controllers so make sure the GPIO
subsystem can be built by selecting ARCH_WANT_OPTIONAL_GPIOLIB.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4e1cc76..c604ef1 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -111,6 +111,7 @@ config ARCH_EMEV2
 
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
-- 
1.8.4
