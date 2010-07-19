From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 19 Jul 2010 12:59:01 +0200
Subject: [PATCH 6/9] [ARM] mmp: rename pxa_map_io() to mmp_map_io()
In-Reply-To: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
References: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1279537144-25424-6-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/aspenite.c      |    4 ++--
 arch/arm/mach-mmp/avengers_lite.c |    2 +-
 arch/arm/mach-mmp/common.c        |    2 +-
 arch/arm/mach-mmp/common.h        |    2 +-
 arch/arm/mach-mmp/flint.c         |    2 +-
 arch/arm/mach-mmp/jasper.c        |    2 +-
 arch/arm/mach-mmp/tavorevb.c      |    2 +-
 arch/arm/mach-mmp/ttc_dkb.c       |    2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 1721c54..0629394 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -151,7 +151,7 @@ static void __init common_init(void)
 MACHINE_START(ASPENITE, "PXA168-based Aspenite Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= mmp_map_io,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = common_init,
@@ -160,7 +160,7 @@ MACHINE_END
 MACHINE_START(ZYLONITE2, "PXA168-based Zylonite2 Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= mmp_map_io,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = common_init,
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 2906c9e..69bcba1 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -43,7 +43,7 @@ static void __init avengers_lite_init(void)
 MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= mmp_map_io,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = avengers_lite_init,
diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index e1e66c1..3b29fa7 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -31,7 +31,7 @@ static struct map_desc standard_io_desc[] __initdata = {
 	},
 };
 
-void __init pxa_map_io(void)
+void __init mmp_map_io(void)
 {
 	iotable_init(standard_io_desc, ARRAY_SIZE(standard_io_desc));
 }
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index b4a0ba0..9696175 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -14,4 +14,4 @@ extern void __init mmp2_init_icu(void);
 extern void __init mmp2_init_irq(void);
 
 extern void __init icu_init_irq(void);
-extern void __init pxa_map_io(void);
+extern void __init mmp_map_io(void);
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index e77bb0a..e4312d2 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -115,7 +115,7 @@ static void __init flint_init(void)
 MACHINE_START(FLINT, "Flint Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= mmp_map_io,
 	.init_irq       = mmp2_init_irq,
 	.timer          = &mmp2_timer,
 	.init_machine   = flint_init,
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 8e2b171..80c3e7a 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -136,7 +136,7 @@ static void __init jasper_init(void)
 MACHINE_START(MARVELL_JASPER, "Jasper Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= mmp_map_io,
 	.init_irq       = mmp2_init_irq,
 	.timer          = &mmp2_timer,
 	.init_machine   = jasper_init,
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index b8b38aa..e81db74 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -101,7 +101,7 @@ static void __init tavorevb_init(void)
 MACHINE_START(TAVOREVB, "PXA910 Evaluation Board (aka TavorEVB)")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= mmp_map_io,
 	.init_irq       = pxa910_init_irq,
 	.timer          = &pxa910_timer,
 	.init_machine   = tavorevb_init,
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index ba3ce41..ee65e05 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -124,7 +124,7 @@ static void __init ttc_dkb_init(void)
 MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= mmp_map_io,
 	.init_irq       = pxa910_init_irq,
 	.timer          = &pxa910_timer,
 	.init_machine   = ttc_dkb_init,
-- 
1.7.1
