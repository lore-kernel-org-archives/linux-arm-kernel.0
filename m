From: andrea.adami@gmail.com (Andrea Adami)
Date: Sun, 21 Jul 2013 01:07:36 +0200
Subject: [PATCH] sa1100: collie: fall back to jedec_probe flash detection
Message-ID: <1374361656-3034-1-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zaurus 5500 contains 2 LH28F640BFHE-PTTL90 (64M 4Mx16) and
the LH28F640BFHE-PTTL90.pdf datasheet available on the net shows
the exact erasesize and the OTP support.
At the moment only jedec_probe can discover the chip and
the NOR is mounted read only probably because of wrong vpp.

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
