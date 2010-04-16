From: r.herring@freescale.com (Rob Herring)
Date: Fri, 16 Apr 2010 14:35:20 -0500
Subject: [RFC PATCH 06/10] mx5: rename mx51_map_io to mx5_map_io
Message-ID: <1271446524-26450-7-git-send-email-r.herring@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rob Herring <r.herring@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c  |    2 +-
 arch/arm/mach-mx5/mm.c                  |    2 +-
 arch/arm/plat-mxc/include/mach/common.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index ee67a71..5c15d6e 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -91,7 +91,7 @@ MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
 	.phys_io = MX51_AIPS1_BASE_ADDR,
 	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params = PHYS_OFFSET + 0x100,
-	.map_io = mx51_map_io,
+	.map_io = mx5_map_io,
 	.init_irq = mx51_init_irq,
 	.init_machine = mxc_board_init,
 	.timer = &mxc_timer,
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index fedacac..8ad1d0c 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -38,7 +38,7 @@ static struct map_desc mxc_io_desc[] __initdata = {
  * system startup to create static physical to virtual memory mappings
  * for the IO modules.
  */
-void __init mx51_map_io(void)
+void __init mx5_map_io(void)
 {
 	void __iomem *base;
 
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 2941472..0766746 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -20,7 +20,7 @@ extern void mx25_map_io(void);
 extern void mx27_map_io(void);
 extern void mx31_map_io(void);
 extern void mx35_map_io(void);
-extern void mx51_map_io(void);
+extern void mx5_map_io(void);
 extern void mxc91231_map_io(void);
 extern void mxc_init_irq(void __iomem *);
 extern void tzic_init_irq(void __iomem *);
-- 
1.6.0.4
