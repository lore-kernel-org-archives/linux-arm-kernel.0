From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Feb 2016 15:06:37 +0100
Subject: [PATCH 1/3] ARM: orion: only select I2C_BOARDINFO when using I2C
In-Reply-To: <1456236403-115511-1-git-send-email-arnd@arndb.de>
References: <1456236403-115511-1-git-send-email-arnd@arndb.de>
Message-ID: <1456236403-115511-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we select I2C_BOARDINFO and I2C is disabled, we get a
harmless Kconfig warning:

warning: (MACH_DOVE_DB && MACH_DB88F5281 && MACH_RD88F5182 && MACH_RD88F5182_DT && MACH_KUROBOX_PRO && MACH_DNS323 && MACH_LINKSTATION_PRO && MACH_LINKSTATION_LSCHL && MACH_LINKSTATION_LS_HGL && MACH_NET2BIG) selects I2C_BOARDINFO which has unmet direct dependencies (I2C)

Making the select itself conditional avoids the warning and
makes the kernel slightly smaller as the compiler will be
able to drop the unused board info.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-dove/Kconfig    |  2 +-
 arch/arm/mach-orion5x/Kconfig | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index 0fd506125cde..5cc9f7450197 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -18,7 +18,7 @@ config DOVE_LEGACY
 config MACH_DOVE_DB
 	bool "Marvell DB-MV88AP510 Development Board"
 	select DOVE_LEGACY
-	select I2C_BOARDINFO
+	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell DB-MV88AP510 Development Board.
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 4c0acd844429..a9ae143703f8 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -28,14 +28,14 @@ config ARCH_ORION5X_DT
 
 config MACH_DB88F5281
 	bool "Marvell Orion-2 Development Board"
-	select I2C_BOARDINFO
+	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Orion-2 (88F5281) Development Board
 
 config MACH_RD88F5182
 	bool "Marvell Orion-NAS Reference Design"
-	select I2C_BOARDINFO
+	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Orion-NAS (88F5182) RD2
@@ -43,14 +43,14 @@ config MACH_RD88F5182
 config MACH_RD88F5182_DT
 	bool "Marvell Orion-NAS Reference Design (Flattened Device Tree)"
 	select ARCH_ORION5X_DT
-	select I2C_BOARDINFO
+	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the Marvell
 	  Orion-NAS (88F5182) RD2, Flattened Device Tree.
 
 config MACH_KUROBOX_PRO
 	bool "KuroBox Pro"
-	select I2C_BOARDINFO
+	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  KuroBox Pro platform.
@@ -58,7 +58,7 @@ config MACH_KUROBOX_PRO
 config MACH_DNS323
 	bool "D-Link DNS-323"
 	select GENERIC_NET_UTILS
-	select I2C_BOARDINFO
+	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  D-Link DNS-323 platform.
@@ -78,7 +78,7 @@ config MACH_TERASTATION_PRO2
 
 config MACH_LINKSTATION_PRO
 	bool "Buffalo Linkstation Pro/Live"
-	select I2C_BOARDINFO
+	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Buffalo Linkstation Pro/Live platform. Both v1 and
@@ -86,7 +86,7 @@ config MACH_LINKSTATION_PRO
 
 config MACH_LINKSTATION_LSCHL
 	bool "Buffalo Linkstation Live v3 (LS-CHL)"
-	select I2C_BOARDINFO
+	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Buffalo Linkstation Live v3 (LS-CHL) platform.
@@ -100,7 +100,7 @@ config MACH_LINKSTATION_MINI
 
 config MACH_LINKSTATION_LS_HGL
 	bool "Buffalo Linkstation LS-HGL"
-	select I2C_BOARDINFO
+	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Buffalo Linkstation LS-HGL platform.
@@ -139,7 +139,7 @@ config MACH_D2NET_DT
 
 config MACH_NET2BIG
 	bool "LaCie 2Big Network"
-	select I2C_BOARDINFO
+	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie 2Big Network NAS.
-- 
2.7.0
