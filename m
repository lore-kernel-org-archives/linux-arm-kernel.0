From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:50 -0400
Subject: [PATCH 05/52] ARM: mach-dove: convert boot-params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-dove/cm-a510.c       |    2 +-
 arch/arm/mach-dove/dove-db-setup.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-dove/cm-a510.c
index 03e11f9..c8a406f 100644
--- a/arch/arm/mach-dove/cm-a510.c
+++ b/arch/arm/mach-dove/cm-a510.c
@@ -87,7 +87,7 @@ static void __init cm_a510_init(void)
 }
 
 MACHINE_START(CM_A510, "Compulab CM-A510 Board")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= cm_a510_init,
 	.map_io		= dove_map_io,
 	.init_early	= dove_init_early,
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index 2ac34ec..11ea34e 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -94,7 +94,7 @@ static void __init dove_db_init(void)
 }
 
 MACHINE_START(DOVE_DB, "Marvell DB-MV88AP510-BP Development Board")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= dove_db_init,
 	.map_io		= dove_map_io,
 	.init_early	= dove_init_early,
-- 
1.7.4
