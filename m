From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 10 Oct 2013 07:57:42 +0900
Subject: [PATCH] ARM: shmobile: Select GPIO in case of the r7s72100 SoC
Message-ID: <20131009225742.7558.62495.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r7s72100 contains GPIO controllers so make sure the GPIO
subsystem can be built by selecting ARCH_WANT_OPTIONAL_GPIOLIB.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-20131008

 arch/arm/mach-shmobile/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-10-07 18:26:15.000000000 +0900
@@ -109,6 +109,7 @@ config ARCH_EMEV2
 
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
