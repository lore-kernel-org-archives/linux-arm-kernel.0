From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  7 Feb 2011 16:35:21 +0100
Subject: [PATCH 3/4] ARM: mx5: use .init_early to initialize cpu type,
	reset address and iomuxer
In-Reply-To: <20110126103107.GA4232@n2100.arm.linux.org.uk>
References: <20110126103107.GA4232@n2100.arm.linux.org.uk>
Message-ID: <1297092922-12741-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This used to be done in .map_io which is supposed to only setup the
memory mapping.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/board-cpuimx51.c      |    3 ++-
 arch/arm/mach-mx5/board-cpuimx51sd.c    |    3 ++-
 arch/arm/mach-mx5/board-mx50_rdp.c      |    3 ++-
 arch/arm/mach-mx5/board-mx51_3ds.c      |    3 ++-
 arch/arm/mach-mx5/board-mx51_babbage.c  |    3 ++-
 arch/arm/mach-mx5/board-mx51_efikamx.c  |    3 ++-
 arch/arm/mach-mx5/board-mx53_evk.c      |    3 ++-
 arch/arm/mach-mx5/board-mx53_loco.c     |    3 ++-
 arch/arm/mach-mx5/board-mx53_smd.c      |    3 ++-
 arch/arm/mach-mx5/mm-mx50.c             |    6 +++++-
 arch/arm/mach-mx5/mm.c                  |   12 ++++++++++--
 arch/arm/plat-mxc/include/mach/common.h |    2 ++
 12 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index f576a97..2d4199d 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -294,7 +294,8 @@ MACHINE_START(EUKREA_CPUIMX51, "Eukrea CPUIMX51 Module")
 	/* Maintainer: Eric B?nard <eric@eukrea.com> */
 	.boot_params = MX51_PHYS_OFFSET + 0x100,
 	.map_io = mx51_map_io,
+	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
-	.init_machine = eukrea_cpuimx51_init,
 	.timer = &mxc_timer,
+	.init_machine = eukrea_cpuimx51_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index ad93189..6c3b445 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -329,7 +329,8 @@ MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
 	/* Maintainer: Eric B?nard <eric@eukrea.com> */
 	.boot_params = MX51_PHYS_OFFSET + 0x100,
 	.map_io = mx51_map_io,
+	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
-	.init_machine = eukrea_cpuimx51sd_init,
 	.timer = &mxc_timer,
+	.init_machine = eukrea_cpuimx51sd_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
index 75beef7..dedf7f2 100644
--- a/arch/arm/mach-mx5/board-mx50_rdp.c
+++ b/arch/arm/mach-mx5/board-mx50_rdp.c
@@ -216,7 +216,8 @@ static struct sys_timer mx50_rdp_timer = {
 
 MACHINE_START(MX50_RDP, "Freescale MX50 Reference Design Platform")
 	.map_io = mx50_map_io,
+	.init_early = imx50_init_early,
 	.init_irq = mx50_init_irq,
-	.init_machine = mx50_rdp_board_init,
 	.timer = &mx50_rdp_timer,
+	.init_machine = mx50_rdp_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 55d5746..0168470 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -168,7 +168,8 @@ MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.boot_params = MX51_PHYS_OFFSET + 0x100,
 	.map_io = mx51_map_io,
+	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
-	.init_machine = mxc_board_init,
 	.timer = &mxc_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index d9d402e..2bd9c9e 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -398,7 +398,8 @@ MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
 	/* Maintainer: Amit Kucheria <amit.kucheria@canonical.com> */
 	.boot_params = MX51_PHYS_OFFSET + 0x100,
 	.map_io = mx51_map_io,
+	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
-	.init_machine = mxc_board_init,
 	.timer = &mxc_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index e237040..2aac4c5 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -347,7 +347,8 @@ MACHINE_START(MX51_EFIKAMX, "Genesi EfikaMX nettop")
 	/* Maintainer: Amit Kucheria <amit.kucheria@linaro.org> */
 	.boot_params = MX51_PHYS_OFFSET + 0x100,
 	.map_io = mx51_map_io,
+	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
-	.init_machine =  mxc_board_init,
 	.timer = &mxc_timer,
+	.init_machine =  mxc_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 4978007..8ed316b 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -150,7 +150,8 @@ static struct sys_timer mx53_evk_timer = {
 
 MACHINE_START(MX53_EVK, "Freescale MX53 EVK Board")
 	.map_io = mx53_map_io,
+	.init_early = imx53_init_early,
 	.init_irq = mx53_init_irq,
-	.init_machine = mx53_evk_board_init,
 	.timer = &mx53_evk_timer,
+	.init_machine = mx53_evk_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 3aefd6d..0fea252 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -82,7 +82,8 @@ static struct sys_timer mx53_loco_timer = {
 
 MACHINE_START(MX53_LOCO, "Freescale MX53 LOCO Board")
 	.map_io = mx53_map_io,
+	.init_early = imx53_init_early,
 	.init_irq = mx53_init_irq,
-	.init_machine = mx53_loco_board_init,
 	.timer = &mx53_loco_timer,
+	.init_machine = mx53_loco_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index c7b45d4..fa0fad8 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -103,7 +103,8 @@ static struct sys_timer mx53_smd_timer = {
 
 MACHINE_START(MX53_SMD, "Freescale MX53 SMD Board")
 	.map_io = mx53_map_io,
+	.init_early = imx53_init_early,
 	.init_irq = mx53_init_irq,
-	.init_machine = mx53_smd_board_init,
 	.timer = &mx53_smd_timer,
+	.init_machine = mx53_smd_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/mm-mx50.c b/arch/arm/mach-mx5/mm-mx50.c
index 8c6540e..69b3426 100644
--- a/arch/arm/mach-mx5/mm-mx50.c
+++ b/arch/arm/mach-mx5/mm-mx50.c
@@ -44,10 +44,14 @@ static struct map_desc mx50_io_desc[] __initdata = {
  */
 void __init mx50_map_io(void)
 {
+	iotable_init(mx50_io_desc, ARRAY_SIZE(mx50_io_desc));
+}
+
+void __init imx50_init_early(void)
+{
 	mxc_set_cpu_type(MXC_CPU_MX50);
 	mxc_iomux_v3_init(MX50_IO_ADDRESS(MX50_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX50_IO_ADDRESS(MX50_WDOG_BASE_ADDR));
-	iotable_init(mx50_io_desc, ARRAY_SIZE(mx50_io_desc));
 }
 
 int imx50_register_gpios(void);
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 457f9f9..8730cd1 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -47,18 +47,26 @@ static struct map_desc mx53_io_desc[] __initdata = {
  */
 void __init mx51_map_io(void)
 {
+	iotable_init(mx51_io_desc, ARRAY_SIZE(mx51_io_desc));
+}
+
+void __init imx51_init_early(void)
+{
 	mxc_set_cpu_type(MXC_CPU_MX51);
 	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
-	iotable_init(mx51_io_desc, ARRAY_SIZE(mx51_io_desc));
 }
 
 void __init mx53_map_io(void)
 {
+	iotable_init(mx53_io_desc, ARRAY_SIZE(mx53_io_desc));
+}
+
+void __init imx53_init_early(void)
+{
 	mxc_set_cpu_type(MXC_CPU_MX53);
 	mxc_iomux_v3_init(MX53_IO_ADDRESS(MX53_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG_BASE_ADDR));
-	iotable_init(mx53_io_desc, ARRAY_SIZE(mx53_io_desc));
 }
 
 int imx51_register_gpios(void);
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 857eebf47..4746b9a 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -31,6 +31,8 @@ extern void imx27_init_early(void);
 extern void imx31_init_early(void);
 extern void imx35_init_early(void);
 extern void imx50_init_early(void);
+extern void imx51_init_early(void);
+extern void imx53_init_early(void);
 extern void mxc_init_irq(void __iomem *);
 extern void tzic_init_irq(void __iomem *);
 extern void mx1_init_irq(void);
-- 
1.7.2.3
