From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 18 Feb 2013 22:47:07 +0900
Subject: [PATCH 02/08] ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
In-Reply-To: <20130218134648.17303.97576.sendpatchset@w520>
References: <20130218134648.17303.97576.sendpatchset@w520>
Message-ID: <20130218134707.17303.48589.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rework the IOMEM() usage for the SCU base address in the
case of sh73a0. Removes recently introduced build warnings:

arch/arm/mach-shmobile/smp-sh73a0.c:45:15: warning: initialization makes integer from pointer without a cast [enabled by default]
arch/arm/mach-shmobile/smp-sh73a0.c:45:15: warning: (near initialization for 'twd_local_timer.res[0].start') [enabled by default]
arch/arm/mach-shmobile/smp-sh73a0.c:45:15: warning: initialization makes integer from pointer without a cast [enabled by default]
/arch/arm/mach-shmobile/smp-sh73a0.c:45:15: warning: (near initialization for 'twd_local_timer.res[0].end') [enabled by default]

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-sh73a0.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2013-02-18 16:24:05.000000000 +0900
@@ -39,7 +39,7 @@
 
 #define PSTR_SHUTDOWN_MODE	3
 
-#define SH73A0_SCU_BASE IOMEM(0xf0000000)
+#define SH73A0_SCU_BASE 0xf0000000
 
 #ifdef CONFIG_HAVE_ARM_TWD
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, SH73A0_SCU_BASE + 0x600, 29);
@@ -81,7 +81,7 @@ static void __init sh73a0_smp_prepare_cp
 static void __init sh73a0_smp_init_cpus(void)
 {
 	/* setup sh73a0 specific SCU base */
-	shmobile_scu_base = SH73A0_SCU_BASE;
+	shmobile_scu_base = IOMEM(SH73A0_SCU_BASE);
 
 	shmobile_smp_init_cpus(scu_get_core_count(shmobile_scu_base));
 }
