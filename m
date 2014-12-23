From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 23 Dec 2014 13:08:51 +0300
Subject: [PATCH] ARM: sa1100: collie: clear PWER register on machine init
Message-ID: <1419329331-4288-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let kernel drivers to control wakeup sources instead of hardcoding them
in the collie.c board file.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/collie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 743a428..d139cf4 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -469,8 +469,7 @@ static void __init collie_init(void)
 		PPC_LDD6 | PPC_LDD7 | PPC_L_PCLK | PPC_L_LCLK | PPC_L_FCLK | PPC_L_BIAS |
 		PPC_TXD1 | PPC_TXD2 | PPC_TXD3 | PPC_TXD4 | PPC_SCLK | PPC_SFRM;
 
-	PWER = _COLLIE_GPIO_AC_IN | _COLLIE_GPIO_CO | _COLLIE_GPIO_ON_KEY |
-		_COLLIE_GPIO_WAKEUP | _COLLIE_GPIO_nREMOCON_INT | PWER_RTC;
+	PWER = 0;
 
 	PGSR = _COLLIE_GPIO_nREMOCON_ON;
 
-- 
2.1.3
