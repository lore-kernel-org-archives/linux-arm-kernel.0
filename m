From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:54 -0400
Subject: [PATCH 09/52] ARM: mach-footbridge: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-9-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-footbridge/cats-hw.c      |    2 +-
 arch/arm/mach-footbridge/ebsa285.c      |    2 +-
 arch/arm/mach-footbridge/netwinder-hw.c |    2 +-
 arch/arm/mach-footbridge/personal.c     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-footbridge/cats-hw.c b/arch/arm/mach-footbridge/cats-hw.c
index 5b1a8db..a3da5d1 100644
--- a/arch/arm/mach-footbridge/cats-hw.c
+++ b/arch/arm/mach-footbridge/cats-hw.c
@@ -86,7 +86,7 @@ fixup_cats(struct machine_desc *desc, struct tag *tags,
 
 MACHINE_START(CATS, "Chalice-CATS")
 	/* Maintainer: Philip Blundell */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.soft_reboot	= 1,
 	.fixup		= fixup_cats,
 	.map_io		= footbridge_map_io,
diff --git a/arch/arm/mach-footbridge/ebsa285.c b/arch/arm/mach-footbridge/ebsa285.c
index 2ef69ff..012210c 100644
--- a/arch/arm/mach-footbridge/ebsa285.c
+++ b/arch/arm/mach-footbridge/ebsa285.c
@@ -15,7 +15,7 @@
 
 MACHINE_START(EBSA285, "EBSA285")
 	/* Maintainer: Russell King */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.video_start	= 0x000a0000,
 	.video_end	= 0x000bffff,
 	.map_io		= footbridge_map_io,
diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
index 06e514f..d8c1c92 100644
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ b/arch/arm/mach-footbridge/netwinder-hw.c
@@ -648,7 +648,7 @@ fixup_netwinder(struct machine_desc *desc, struct tag *tags,
 
 MACHINE_START(NETWINDER, "Rebel-NetWinder")
 	/* Maintainer: Russell King/Rebel.com */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.video_start	= 0x000a0000,
 	.video_end	= 0x000bffff,
 	.reserve_lp0	= 1,
diff --git a/arch/arm/mach-footbridge/personal.c b/arch/arm/mach-footbridge/personal.c
index 3285e91..f41dba3 100644
--- a/arch/arm/mach-footbridge/personal.c
+++ b/arch/arm/mach-footbridge/personal.c
@@ -15,7 +15,7 @@
 
 MACHINE_START(PERSONAL_SERVER, "Compaq-PersonalServer")
 	/* Maintainer: Jamey Hicks / George France */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= footbridge_map_io,
 	.init_irq	= footbridge_init_irq,
 	.timer		= &footbridge_timer,
-- 
1.7.4
