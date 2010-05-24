From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 24 May 2010 14:35:48 +0800
Subject: [PATCH 5/6] [ARM] pxa/balloon3: encode number of IRQ into .nr_irqs
In-Reply-To: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
References: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1274682949-25915-6-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Jonathan McDowell <noodles@earth.li>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig                 |    1 -
 arch/arm/mach-pxa/balloon3.c              |    1 +
 arch/arm/mach-pxa/include/mach/balloon3.h |    1 +
 3 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 60b3c17..3378c79 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -74,7 +74,6 @@ config MACH_BALLOON3
 	bool "Balloon 3 board"
 	select PXA27x
 	select IWMMXT
-	select PXA_HAVE_BOARD_IRQS
 
 config MACH_CSB726
 	bool "Enable Cogent CSB726 System On a Module"
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index f3b5ace..c9a50b3 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -349,6 +349,7 @@ MACHINE_START(BALLOON3, "Balloon3")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= balloon3_map_io,
+	.nr_irqs	= BALLOON3_NR_IRQS,
 	.init_irq	= balloon3_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= balloon3_init,
diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index 1a74106..1b76a00 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -131,6 +131,7 @@ enum balloon3_features {
 
 /* Balloon3 Interrupts */
 #define BALLOON3_IRQ(x)		(IRQ_BOARD_START + (x))
+#define BALLOON3_NR_IRQS	(IRQ_BOARD_START + 8)
 
 #define BALLOON3_BP_CF_NRDY_IRQ	BALLOON3_IRQ(0)
 #define BALLOON3_BP_NSTSCHG_IRQ	BALLOON3_IRQ(1)
-- 
1.7.0.4
