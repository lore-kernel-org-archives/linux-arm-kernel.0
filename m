From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:13:45 +0200
Subject: [PATCH 09/10] ARM: ux500: rename ux500_map_io
Message-ID: <1431620025-15174-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is not mapping any I/O other than for probing
the chip ID. Rename it to make the function graspable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c | 2 +-
 arch/arm/mach-ux500/id.c         | 2 +-
 arch/arm/mach-ux500/setup.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index d9359d7b80d7..16913800bbf9 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -46,7 +46,7 @@ static struct prcmu_pdata db8500_prcmu_pdata = {
 static void __init u8500_map_io(void)
 {
 	debug_ll_io_init();
-	ux500_map_io();
+	ux500_setup_id();
 }
 
 /*
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index 392f2fdb37d0..1e81e990044b 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -72,7 +72,7 @@ static unsigned int partnumber(unsigned int asicid)
  * DB9540	0x413fc090	0xFFFFDBF4		0x009540xx
  */
 
-void __init ux500_map_io(void)
+void __init ux500_setup_id(void)
 {
 	unsigned int cpuid = read_cpuid_id();
 	unsigned int asicid = 0;
diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index 2dea8b59d222..cf5a8736ea9d 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -18,7 +18,7 @@
 
 void ux500_restart(enum reboot_mode mode, const char *cmd);
 
-void __init ux500_map_io(void);
+void __init ux500_setup_id(void);
 
 extern void __init ux500_init_irq(void);
 
-- 
1.9.3
