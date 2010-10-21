From: simon@sequanux.org (Simon Guinot)
Date: Thu, 21 Oct 2010 11:42:29 +0200
Subject: [PATCH v2 2/2] [ARM] Kirkwood: fix timer initialization for LaCie
	boards
In-Reply-To: <1287654149-8743-1-git-send-email-simon@sequanux.org>
References: <20101020085720.GA12979@mail.wantstofly.org>
	<1287654149-8743-1-git-send-email-simon@sequanux.org>
Message-ID: <1287654149-8743-2-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

Signed-off-by: Simon Guinot <sguinot@lacie.com>
Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 arch/arm/mach-kirkwood/d2net_v2-setup.c    |    2 +-
 arch/arm/mach-kirkwood/lacie_v2-common.c   |   14 --------------
 arch/arm/mach-kirkwood/lacie_v2-common.h   |    2 --
 arch/arm/mach-kirkwood/netspace_v2-setup.c |    6 +++---
 arch/arm/mach-kirkwood/netxbig_v2-setup.c  |    4 ++--
 5 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-kirkwood/d2net_v2-setup.c b/arch/arm/mach-kirkwood/d2net_v2-setup.c
index cd62d0f..b8078ae 100644
--- a/arch/arm/mach-kirkwood/d2net_v2-setup.c
+++ b/arch/arm/mach-kirkwood/d2net_v2-setup.c
@@ -227,5 +227,5 @@ MACHINE_START(D2NET_V2, "LaCie d2 Network v2")
 	.init_machine	= d2net_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &lacie_v2_timer,
+	.timer		= &kirkwood_timer,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.c b/arch/arm/mach-kirkwood/lacie_v2-common.c
index d3ea1b6..285edab 100644
--- a/arch/arm/mach-kirkwood/lacie_v2-common.c
+++ b/arch/arm/mach-kirkwood/lacie_v2-common.c
@@ -111,17 +111,3 @@ void __init lacie_v2_hdd_power_init(int hdd_num)
 			pr_err("Failed to power up HDD%d\n", i + 1);
 	}
 }
-
-/*****************************************************************************
- * Timer
- ****************************************************************************/
-
-static void lacie_v2_timer_init(void)
-{
-	kirkwood_tclk = 166666667;
-	orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
-}
-
-struct sys_timer lacie_v2_timer = {
-	.init = lacie_v2_timer_init,
-};
diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.h b/arch/arm/mach-kirkwood/lacie_v2-common.h
index af52131..fc64f57 100644
--- a/arch/arm/mach-kirkwood/lacie_v2-common.h
+++ b/arch/arm/mach-kirkwood/lacie_v2-common.h
@@ -13,6 +13,4 @@ void lacie_v2_register_flash(void);
 void lacie_v2_register_i2c_devices(void);
 void lacie_v2_hdd_power_init(int hdd_num);
 
-extern struct sys_timer lacie_v2_timer;
-
 #endif
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index fed264d..fc934e5 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -221,7 +221,7 @@ MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &lacie_v2_timer,
+	.timer		= &kirkwood_timer,
 MACHINE_END
 #endif
 
@@ -233,7 +233,7 @@ MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &lacie_v2_timer,
+	.timer		= &kirkwood_timer,
 MACHINE_END
 #endif
 
@@ -245,6 +245,6 @@ MACHINE_START(NETSPACE_MAX_V2, "LaCie Network Space Max v2")
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &lacie_v2_timer,
+	.timer		= &kirkwood_timer,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
index d970e1e..a855c9f 100644
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
@@ -405,7 +405,7 @@ MACHINE_START(NET2BIG_V2, "LaCie 2Big Network v2")
 	.init_machine	= netxbig_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &lacie_v2_timer,
+	.timer		= &kirkwood_timer,
 MACHINE_END
 #endif
 
@@ -417,6 +417,6 @@ MACHINE_START(NET5BIG_V2, "LaCie 5Big Network v2")
 	.init_machine	= netxbig_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &lacie_v2_timer,
+	.timer		= &kirkwood_timer,
 MACHINE_END
 #endif
-- 
1.6.3.1
