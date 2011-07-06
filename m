From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:00 -0400
Subject: [PATCH 15/52] ARM: mach-iop32x: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-15-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-iop32x/em7210.c   |    2 +-
 arch/arm/mach-iop32x/glantank.c |    2 +-
 arch/arm/mach-iop32x/iq31244.c  |    4 ++--
 arch/arm/mach-iop32x/iq80321.c  |    2 +-
 arch/arm/mach-iop32x/n2100.c    |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 779f924..4fb35c3 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -203,7 +203,7 @@ static void __init em7210_init_machine(void)
 }
 
 MACHINE_START(EM7210, "Lanner EM7210")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= em7210_map_io,
 	.init_irq	= iop32x_init_irq,
 	.timer		= &em7210_timer,
diff --git a/arch/arm/mach-iop32x/glantank.c b/arch/arm/mach-iop32x/glantank.c
index c6b6f9c..c6d6426f 100644
--- a/arch/arm/mach-iop32x/glantank.c
+++ b/arch/arm/mach-iop32x/glantank.c
@@ -207,7 +207,7 @@ static void __init glantank_init_machine(void)
 
 MACHINE_START(GLANTANK, "GLAN Tank")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= glantank_map_io,
 	.init_irq	= iop32x_init_irq,
 	.timer		= &glantank_timer,
diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index fde962c..787e96a 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -313,7 +313,7 @@ __setup("force_ep80219", force_ep80219_setup);
 
 MACHINE_START(IQ31244, "Intel IQ31244")
 	/* Maintainer: Intel Corp. */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= iq31244_map_io,
 	.init_irq	= iop32x_init_irq,
 	.timer		= &iq31244_timer,
@@ -327,7 +327,7 @@ MACHINE_END
  */
 MACHINE_START(EP80219, "Intel EP80219")
 	/* Maintainer: Intel Corp. */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= iq31244_map_io,
 	.init_irq	= iop32x_init_irq,
 	.timer		= &iq31244_timer,
diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index 3a95950e..cf57896 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -186,7 +186,7 @@ static void __init iq80321_init_machine(void)
 
 MACHINE_START(IQ80321, "Intel IQ80321")
 	/* Maintainer: Intel Corp. */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= iq80321_map_io,
 	.init_irq	= iop32x_init_irq,
 	.timer		= &iq80321_timer,
diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index 626aa37..2683a14 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -327,7 +327,7 @@ static void __init n2100_init_machine(void)
 
 MACHINE_START(N2100, "Thecus N2100")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= n2100_map_io,
 	.init_irq	= iop32x_init_irq,
 	.timer		= &n2100_timer,
-- 
1.7.4
