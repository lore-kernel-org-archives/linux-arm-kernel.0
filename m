From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 22 Mar 2017 19:21:01 +0100
Subject: [PATCH v3 4/5] ARM: davinci: add pata_bk3710 libata driver support
In-Reply-To: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
References: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170322182143epcas5p3ed7e25912e24ae67b5593d2baaf63791@epcas5p3.samsung.com>
Message-ID: <1490206862-26065-5-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
[b.zolnierkie: split from bigger patch + preserved old driver support]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c  | 3 ++-
 arch/arm/mach-davinci/board-dm646x-evm.c  | 3 ++-
 arch/arm/mach-davinci/board-neuros-osd2.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 023480b..20f1874 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -744,7 +744,8 @@ static int davinci_phy_fixup(struct phy_device *phydev)
 	return 0;
 }
 
-#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
+#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
+			 IS_ENABLED(CONFIG_PATA_BK3710))
 
 #define HAS_NOR		IS_ENABLED(CONFIG_MTD_PHYSMAP)
 
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index f702d4f..cb17682 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -119,7 +119,8 @@
 	},
 };
 
-#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
+#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
+			 IS_ENABLED(CONFIG_PATA_BK3710))
 
 #ifdef CONFIG_I2C
 /* CPLD Register 0 bits to control ATA */
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 0a78388..0c02aaa 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -163,7 +163,8 @@ static void __init davinci_ntosd2_map_io(void)
 	.wires		= 4,
 };
 
-#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
+#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
+			 IS_ENABLED(CONFIG_PATA_BK3710))
 
 #define HAS_NAND	IS_ENABLED(CONFIG_MTD_NAND_DAVINCI)
 
-- 
1.9.1
