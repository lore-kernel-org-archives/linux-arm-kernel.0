From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri,  1 Apr 2011 17:56:22 +0400
Subject: [PATCH 1/7] balloon3: drop udc_is_connected
Message-ID: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Balloon3 is a pxa270 machins and pxa27x_udc driver doesn't pay any attention
to udc_is_connected, so drop it.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index bfbecec..79cabe8 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -317,14 +317,8 @@ static void balloon3_udc_command(int cmd)
 		UP2OCR &= ~UP2OCR_DPPUE;
 }
 
-static int balloon3_udc_is_connected(void)
-{
-	return 1;
-}
-
 static struct pxa2xx_udc_mach_info balloon3_udc_info __initdata = {
 	.udc_command		= balloon3_udc_command,
-	.udc_is_connected	= balloon3_udc_is_connected,
 	.gpio_pullup		= -1,
 };
 
-- 
1.7.4.1
