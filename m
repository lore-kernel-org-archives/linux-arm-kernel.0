From: sbranden@broadcom.com (Scott Branden)
Date: Tue, 21 Oct 2014 19:09:52 -0700
Subject: [PATCH v6 6/6] ARM: mach-bcm: Consolidate currently supported IPROC
 SoCs
In-Reply-To: <1413943792-7379-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1413943792-7379-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1413943792-7379-7-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move ARCH_BCM_5301X subarch under ARCH_IPROC architecture.
Additional IPROC chipsets that share a lot of commonality should be
added under ARCH_IPROC as well.

Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig |   37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index f5e638e..a51f191 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -33,6 +33,22 @@ config ARCH_BCM_CYGNUS
 	  BCM11300, BCM11320, BCM11350, BCM11360,
 	  BCM58300, BCM58302, BCM58303, BCM58305.
 
+config ARCH_BCM_5301X
+	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
+	select ARCH_BCM_IPROC
+	help
+	  Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
+
+	  This is a network SoC line mostly used in home routers and
+	  wifi access points, it's internal name is Northstar.
+	  This inclused the following SoC: BCM53010, BCM53011, BCM53012,
+	  BCM53014, BCM53015, BCM53016, BCM53017, BCM53018, BCM4707,
+	  BCM4708 and BCM4709.
+
+	  Do not confuse this with the BCM4760 which is a totally
+	  different SoC or with the older BCM47XX and BCM53XX based
+	  network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
+
 config ARCH_BCM_MOBILE
 	bool "Broadcom Mobile SoC Support" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
@@ -106,27 +122,6 @@ config ARCH_BCM2835
 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
 	  used in the Raspberry Pi and Roku 2 devices.
 
-config ARCH_BCM_5301X
-	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
-	select ARM_GIC
-	select CACHE_L2X0
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select ARM_GLOBAL_TIMER
-	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-	help
-	  Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
-
-	  This is a network SoC line mostly used in home routers and
-	  wifi access points, it's internal name is Northstar.
-	  This inclused the following SoC: BCM53010, BCM53011, BCM53012,
-	  BCM53014, BCM53015, BCM53016, BCM53017, BCM53018, BCM4707,
-	  BCM4708 and BCM4709.
-
-	  Do not confuse this with the BCM4760 which is a totally
-	  different SoC or with the older BCM47XX and BCM53XX based
-	  network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
-
 config ARCH_BCM_63XX
 	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
 	depends on MMU
-- 
1.7.9.5
