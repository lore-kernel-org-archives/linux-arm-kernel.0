From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat,  6 Nov 2010 23:34:03 +0100
Subject: [PATCH] PalmTX: Fix ifdef around gen_nand driver registration
Message-ID: <1289082843-9917-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Rafael Gandolfi <kaillasse91@hotmail.fr>
Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/palmtx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 8943296..595f002 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -241,7 +241,8 @@ static inline void palmtx_keys_init(void) {}
 /******************************************************************************
  * NAND Flash
  ******************************************************************************/
-#if defined(CONFIG_MTD_NAND_GPIO) || defined(CONFIG_MTD_NAND_GPIO_MODULE)
+#if defined(CONFIG_MTD_NAND_PLATFORM) || \
+	defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
 static void palmtx_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
 				 unsigned int ctrl)
 {
-- 
1.7.2.3
