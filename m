From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:05 -0400
Subject: [PATCH 20/52] ARM: mach-kirkwood: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-20-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-kirkwood/d2net_v2-setup.c        |    2 +-
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c    |    2 +-
 arch/arm/mach-kirkwood/dockstar-setup.c        |    2 +-
 arch/arm/mach-kirkwood/guruplug-setup.c        |    2 +-
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c |    2 +-
 arch/arm/mach-kirkwood/netspace_v2-setup.c     |    6 +++---
 arch/arm/mach-kirkwood/netxbig_v2-setup.c      |    4 ++--
 arch/arm/mach-kirkwood/openrd-setup.c          |    6 +++---
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    2 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c       |    2 +-
 arch/arm/mach-kirkwood/sheevaplug-setup.c      |    4 ++--
 arch/arm/mach-kirkwood/t5325-setup.c           |    2 +-
 arch/arm/mach-kirkwood/ts219-setup.c           |    2 +-
 arch/arm/mach-kirkwood/ts41x-setup.c           |    2 +-
 14 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-kirkwood/d2net_v2-setup.c b/arch/arm/mach-kirkwood/d2net_v2-setup.c
index 043cfd5..f457e07 100644
--- a/arch/arm/mach-kirkwood/d2net_v2-setup.c
+++ b/arch/arm/mach-kirkwood/d2net_v2-setup.c
@@ -221,7 +221,7 @@ static void __init d2net_v2_init(void)
 }
 
 MACHINE_START(D2NET_V2, "LaCie d2 Network v2")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= d2net_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
index bff04e0..ff4c21c 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
@@ -97,7 +97,7 @@ subsys_initcall(db88f6281_pci_init);
 
 MACHINE_START(DB88F6281_BP, "Marvell DB-88F6281-BP Development Board")
 	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= db88f6281_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/dockstar-setup.c b/arch/arm/mach-kirkwood/dockstar-setup.c
index f14dfb8..e4d199b 100644
--- a/arch/arm/mach-kirkwood/dockstar-setup.c
+++ b/arch/arm/mach-kirkwood/dockstar-setup.c
@@ -102,7 +102,7 @@ static void __init dockstar_init(void)
 }
 
 MACHINE_START(DOCKSTAR, "Seagate FreeAgent DockStar")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= dockstar_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
index 41d1b40..6c40f78 100644
--- a/arch/arm/mach-kirkwood/guruplug-setup.c
+++ b/arch/arm/mach-kirkwood/guruplug-setup.c
@@ -121,7 +121,7 @@ static void __init guruplug_init(void)
 
 MACHINE_START(GURUPLUG, "Marvell GuruPlug Reference Board")
 	/* Maintainer: Siddarth Gore <gores@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= guruplug_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
index 00cca22..9a1e917 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
@@ -163,7 +163,7 @@ subsys_initcall(mv88f6281gtw_ge_pci_init);
 
 MACHINE_START(MV88F6281GTW_GE, "Marvell 88F6281 GTW GE Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= mv88f6281gtw_ge_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index 7cdab57..8849bcc 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -258,7 +258,7 @@ static void __init netspace_v2_init(void)
 
 #ifdef CONFIG_MACH_NETSPACE_V2
 MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
@@ -269,7 +269,7 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_INETSPACE_V2
 MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
@@ -280,7 +280,7 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_NETSPACE_MAX_V2
 MACHINE_START(NETSPACE_MAX_V2, "LaCie Network Space Max v2")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
index 6be627d..1ba12c4 100644
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
@@ -399,7 +399,7 @@ static void __init netxbig_v2_init(void)
 
 #ifdef CONFIG_MACH_NET2BIG_V2
 MACHINE_START(NET2BIG_V2, "LaCie 2Big Network v2")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= netxbig_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
@@ -410,7 +410,7 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_NET5BIG_V2
 MACHINE_START(NET5BIG_V2, "LaCie 5Big Network v2")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= netxbig_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index f69beef..5660ca6 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -214,7 +214,7 @@ subsys_initcall(openrd_pci_init);
 #ifdef CONFIG_MACH_OPENRD_BASE
 MACHINE_START(OPENRD_BASE, "Marvell OpenRD Base Board")
 	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= openrd_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
@@ -226,7 +226,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_OPENRD_CLIENT
 MACHINE_START(OPENRD_CLIENT, "Marvell OpenRD Client Board")
 	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= openrd_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
@@ -238,7 +238,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_OPENRD_ULTIMATE
 MACHINE_START(OPENRD_ULTIMATE, "Marvell OpenRD Ultimate Board")
 	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= openrd_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
index 75c6601..6663869 100644
--- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
@@ -79,7 +79,7 @@ subsys_initcall(rd88f6192_pci_init);
 
 MACHINE_START(RD88F6192_NAS, "Marvell RD-88F6192-NAS Development Board")
 	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= rd88f6192_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-kirkwood/rd88f6281-setup.c
index 0f75494..66b3c05 100644
--- a/arch/arm/mach-kirkwood/rd88f6281-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6281-setup.c
@@ -115,7 +115,7 @@ subsys_initcall(rd88f6281_pci_init);
 
 MACHINE_START(RD88F6281, "Marvell RD-88F6281 Reference Board")
 	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= rd88f6281_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index 17de0bf..8b102d6 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -138,7 +138,7 @@ static void __init sheevaplug_init(void)
 #ifdef CONFIG_MACH_SHEEVAPLUG
 MACHINE_START(SHEEVAPLUG, "Marvell SheevaPlug Reference Board")
 	/* Maintainer: shadi Ammouri <shadi@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= sheevaplug_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
@@ -149,7 +149,7 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_ESATA_SHEEVAPLUG
 MACHINE_START(ESATA_SHEEVAPLUG, "Marvell eSATA SheevaPlug Reference Board")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= sheevaplug_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/t5325-setup.c b/arch/arm/mach-kirkwood/t5325-setup.c
index e6b9b1b..ea104fb 100644
--- a/arch/arm/mach-kirkwood/t5325-setup.c
+++ b/arch/arm/mach-kirkwood/t5325-setup.c
@@ -201,7 +201,7 @@ subsys_initcall(hp_t5325_pci_init);
 
 MACHINE_START(T5325, "HP t5325 Thin Client")
 	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= hp_t5325_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index 68f32f2..262c034 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -132,7 +132,7 @@ subsys_initcall(ts219_pci_init);
 
 MACHINE_START(TS219, "QNAP TS-119/TS-219")
 	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= qnap_ts219_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
index d5d0099..b68f5b4 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c
@@ -176,7 +176,7 @@ subsys_initcall(ts41x_pci_init);
 
 MACHINE_START(TS41X, "QNAP TS-41x")
 	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= qnap_ts41x_init,
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
-- 
1.7.4
