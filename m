From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:10 -0400
Subject: [PATCH 25/52] ARM: mach-mv78xx0: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-25-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c  |    2 +-
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c   |    2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index 20f3f12..0e94268 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -145,7 +145,7 @@ subsys_initcall(wxl_pci_init);
 
 MACHINE_START(TERASTATION_WXL, "Buffalo Nas WXL")
 	/* Maintainer: Sebastien Requiem <sebastien@requiem.fr> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= wxl_init,
 	.map_io		= mv78xx0_map_io,
 	.init_early	= mv78xx0_init_early,
diff --git a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
index df5aebe..50b85ae 100644
--- a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
+++ b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
@@ -93,7 +93,7 @@ subsys_initcall(db78x00_pci_init);
 
 MACHINE_START(DB78X00_BP, "Marvell DB-78x00-BP Development Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= db78x00_init,
 	.map_io		= mv78xx0_map_io,
 	.init_early	= mv78xx0_init_early,
diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
index d927f14..e85222e 100644
--- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
+++ b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
@@ -78,7 +78,7 @@ subsys_initcall(rd78x00_pci_init);
 
 MACHINE_START(RD78X00_MASA, "Marvell RD-78x00-MASA Development Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= rd78x00_masa_init,
 	.map_io		= mv78xx0_map_io,
 	.init_early	= mv78xx0_init_early,
-- 
1.7.4
