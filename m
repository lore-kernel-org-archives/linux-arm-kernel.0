From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:02 -0400
Subject: [PATCH 17/52] ARM: mach-ixp2000: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-17-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ixp2000/enp2611.c  |    2 +-
 arch/arm/mach-ixp2000/ixdp2400.c |    2 +-
 arch/arm/mach-ixp2000/ixdp2800.c |    2 +-
 arch/arm/mach-ixp2000/ixdp2x01.c |    6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ixp2000/enp2611.c b/arch/arm/mach-ixp2000/enp2611.c
index 88663ab..6e843d97 100644
--- a/arch/arm/mach-ixp2000/enp2611.c
+++ b/arch/arm/mach-ixp2000/enp2611.c
@@ -253,7 +253,7 @@ static void __init enp2611_init_machine(void)
 
 MACHINE_START(ENP2611, "Radisys ENP-2611 PCI network processor board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= enp2611_map_io,
 	.init_irq	= ixp2000_init_irq,
 	.timer		= &enp2611_timer,
diff --git a/arch/arm/mach-ixp2000/ixdp2400.c b/arch/arm/mach-ixp2000/ixdp2400.c
index dfffc1e..62fea84 100644
--- a/arch/arm/mach-ixp2000/ixdp2400.c
+++ b/arch/arm/mach-ixp2000/ixdp2400.c
@@ -170,7 +170,7 @@ void __init ixdp2400_init_irq(void)
 
 MACHINE_START(IXDP2400, "Intel IXDP2400 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= ixdp2x00_map_io,
 	.init_irq	= ixdp2400_init_irq,
 	.timer		= &ixdp2400_timer,
diff --git a/arch/arm/mach-ixp2000/ixdp2800.c b/arch/arm/mach-ixp2000/ixdp2800.c
index cd4c9bc..ae73e73 100644
--- a/arch/arm/mach-ixp2000/ixdp2800.c
+++ b/arch/arm/mach-ixp2000/ixdp2800.c
@@ -285,7 +285,7 @@ void __init ixdp2800_init_irq(void)
 
 MACHINE_START(IXDP2800, "Intel IXDP2800 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= ixdp2x00_map_io,
 	.init_irq	= ixdp2800_init_irq,
 	.timer		= &ixdp2800_timer,
diff --git a/arch/arm/mach-ixp2000/ixdp2x01.c b/arch/arm/mach-ixp2000/ixdp2x01.c
index 84835b2..12b6e08 100644
--- a/arch/arm/mach-ixp2000/ixdp2x01.c
+++ b/arch/arm/mach-ixp2000/ixdp2x01.c
@@ -416,7 +416,7 @@ static void __init ixdp2x01_init_machine(void)
 #ifdef CONFIG_ARCH_IXDP2401
 MACHINE_START(IXDP2401, "Intel IXDP2401 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= ixdp2x01_map_io,
 	.init_irq	= ixdp2x01_init_irq,
 	.timer		= &ixdp2x01_timer,
@@ -427,7 +427,7 @@ MACHINE_END
 #ifdef CONFIG_ARCH_IXDP2801
 MACHINE_START(IXDP2801, "Intel IXDP2801 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= ixdp2x01_map_io,
 	.init_irq	= ixdp2x01_init_irq,
 	.timer		= &ixdp2x01_timer,
@@ -440,7 +440,7 @@ MACHINE_END
  */
 MACHINE_START(IXDP28X5, "Intel IXDP2805/2855 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= ixdp2x01_map_io,
 	.init_irq	= ixdp2x01_init_irq,
 	.timer		= &ixdp2x01_timer,
-- 
1.7.4
