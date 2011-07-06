From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:11 -0400
Subject: =?UTF-8?q?=5BPATCH=2026/52=5D=20ARM=3A=20mach-mx5=3A=20convert=20boot=5Fparams=20to=20atag=5Foffset?=
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-26-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-mx5/board-cpuimx51.c     |    2 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c   |    2 +-
 arch/arm/mach-mx5/board-mx51_3ds.c     |    2 +-
 arch/arm/mach-mx5/board-mx51_babbage.c |    2 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c |    2 +-
 arch/arm/mach-mx5/board-mx51_efikasb.c |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 4efa02e..6621ecf 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -295,7 +295,7 @@ static struct sys_timer mxc_timer = {
 
 MACHINE_START(EUKREA_CPUIMX51, "Eukrea CPUIMX51 Module")
 	/* Maintainer: Eric B?nard <eric@eukrea.com> */
-	.boot_params = MX51_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index 5ef25a5..92945ca 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -329,7 +329,7 @@ static struct sys_timer mxc_timer = {
 
 MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
 	/* Maintainer: Eric B?nard <eric@eukrea.com> */
-	.boot_params = MX51_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 63dfbea..1a6b925 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -166,7 +166,7 @@ static struct sys_timer mx51_3ds_timer = {
 
 MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params = MX51_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index c7b3fab..b055b61 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -394,7 +394,7 @@ static struct sys_timer mx51_babbage_timer = {
 
 MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
 	/* Maintainer: Amit Kucheria <amit.kucheria@canonical.com> */
-	.boot_params = MX51_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index 6e36231..a262e77 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -285,7 +285,7 @@ static struct sys_timer mx51_efikamx_timer = {
 
 MACHINE_START(MX51_EFIKAMX, "Genesi EfikaMX nettop")
 	/* Maintainer: Amit Kucheria <amit.kucheria@linaro.org> */
-	.boot_params = MX51_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
index 474fc6e..e794d41 100644
--- a/arch/arm/mach-mx5/board-mx51_efikasb.c
+++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
@@ -271,7 +271,7 @@ static struct sys_timer mx51_efikasb_timer = {
 };
 
 MACHINE_START(MX51_EFIKASB, "Genesi Efika Smartbook")
-	.boot_params = MX51_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
-- 
1.7.4
