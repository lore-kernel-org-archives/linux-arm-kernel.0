From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:27 +0400
Subject: [PATCH 01/15] ARM: pxa/balloon3: drop udc_is_connected
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Balloon3 is a pxa270 machins and pxa27x_udc driver doesn't pay any attention
to udc_is_connected, so drop it.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 810a982..4d0d8c3 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -316,14 +316,8 @@ static void balloon3_udc_command(int cmd)
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
1.7.5.4
