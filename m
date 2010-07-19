From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 19 Jul 2010 12:59:00 +0200
Subject: [PATCH 5/9] [ARM] mmp: remove never supported .boot_params for MMP
In-Reply-To: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
References: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1279537144-25424-5-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/aspenite.c      |    2 --
 arch/arm/mach-mmp/avengers_lite.c |    1 -
 arch/arm/mach-mmp/flint.c         |    1 -
 arch/arm/mach-mmp/jasper.c        |    1 -
 arch/arm/mach-mmp/tavorevb.c      |    1 -
 arch/arm/mach-mmp/ttc_dkb.c       |    1 -
 6 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 244655d..1721c54 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -150,7 +150,6 @@ static void __init common_init(void)
 
 MACHINE_START(ASPENITE, "PXA168-based Aspenite Development Platform")
 	.phys_io        = APB_PHYS_BASE,
-	.boot_params    = 0x00000100,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = pxa168_init_irq,
@@ -160,7 +159,6 @@ MACHINE_END
 
 MACHINE_START(ZYLONITE2, "PXA168-based Zylonite2 Development Platform")
 	.phys_io        = APB_PHYS_BASE,
-	.boot_params    = 0x00000100,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = pxa168_init_irq,
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 8c3fa5d..2906c9e 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -42,7 +42,6 @@ static void __init avengers_lite_init(void)
 
 MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
 	.phys_io        = APB_PHYS_BASE,
-	.boot_params    = 0x00000100,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = pxa168_init_irq,
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index 4ec7709..e77bb0a 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -114,7 +114,6 @@ static void __init flint_init(void)
 
 MACHINE_START(FLINT, "Flint Development Platform")
 	.phys_io        = APB_PHYS_BASE,
-	.boot_params    = 0x00000100,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = mmp2_init_irq,
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index d77dd41..8e2b171 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -135,7 +135,6 @@ static void __init jasper_init(void)
 
 MACHINE_START(MARVELL_JASPER, "Jasper Development Platform")
 	.phys_io        = APB_PHYS_BASE,
-	.boot_params    = 0x00000100,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = mmp2_init_irq,
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 0e0c922..b8b38aa 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -100,7 +100,6 @@ static void __init tavorevb_init(void)
 
 MACHINE_START(TAVOREVB, "PXA910 Evaluation Board (aka TavorEVB)")
 	.phys_io        = APB_PHYS_BASE,
-	.boot_params    = 0x00000100,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = pxa910_init_irq,
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index b22dec4..ba3ce41 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -123,7 +123,6 @@ static void __init ttc_dkb_init(void)
 
 MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
 	.phys_io        = APB_PHYS_BASE,
-	.boot_params    = 0x00000100,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = pxa910_init_irq,
-- 
1.7.1
