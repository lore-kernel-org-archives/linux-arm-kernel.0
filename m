From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:20 -0400
Subject: [PATCH 35/52] ARM: mach-realview: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-35-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-realview/realview_eb.c     |    2 +-
 arch/arm/mach-realview/realview_pb1176.c |    2 +-
 arch/arm/mach-realview/realview_pb11mp.c |    2 +-
 arch/arm/mach-realview/realview_pba8.c   |    2 +-
 arch/arm/mach-realview/realview_pbx.c    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 006a11b..714993d 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -463,7 +463,7 @@ static void __init realview_eb_init(void)
 
 MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
+	.atag_offset	= 0x100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_eb_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index a43ca35..ba55b47 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -358,7 +358,7 @@ static void __init realview_pb1176_init(void)
 
 MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
+	.atag_offset	= 0x100,
 	.fixup		= realview_pb1176_fixup,
 	.map_io		= realview_pb1176_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 1f56fef..516e73e 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -360,7 +360,7 @@ static void __init realview_pb11mp_init(void)
 
 MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
+	.atag_offset	= 0x100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pb11mp_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 64374d7..0398e75 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -310,7 +310,7 @@ static void __init realview_pba8_init(void)
 
 MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
+	.atag_offset	= 0x100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pba8_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 1f9eae6..3bebb50 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -393,7 +393,7 @@ static void __init realview_pbx_init(void)
 
 MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
+	.atag_offset	= 0x100,
 	.fixup		= realview_pbx_fixup,
 	.map_io		= realview_pbx_map_io,
 	.init_early	= realview_init_early,
-- 
1.7.4
