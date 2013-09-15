From: andrea.adami@gmail.com (Andrea Adami)
Date: Mon, 16 Sep 2013 00:04:42 +0200
Subject: [PATCH v2] ARM: sa1100: collie.c: fall back to jedec_probe flash
 detection
Message-ID: <1379282682-26985-1-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zaurus collie contains 2 LH28F640BFHE-PTTL90 (64M 4Mx16) and
at the moment cfi will not detect the collie NOR.
In the meanwhile we can revert to the jedec-probe map which has been
fixed with following commit:

mtd: jedec_probe: fix LH28F640BF definition
fe2f4c8e0bf2756b670ee78fa9772613a2ea8495

Somehow this is unsatisfactory because the flash is mounted READ ONLY
(as from factory, with a RO cramfs)

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 arch/arm/mach-sa1100/collie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 612a456..7fb96eb 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -289,7 +289,7 @@ static void collie_flash_exit(void)
 }
 
 static struct flash_platform_data collie_flash_data = {
-	.map_name	= "cfi_probe",
+	.map_name	= "jedec_probe",
 	.init		= collie_flash_init,
 	.set_vpp	= collie_set_vpp,
 	.exit		= collie_flash_exit,
-- 
1.8.1.5
