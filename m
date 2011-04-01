From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri,  1 Apr 2011 17:56:24 +0400
Subject: [PATCH 3/7] stargate2: udc_is_connected is ignored for pxa27x, drop it
In-Reply-To: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
References: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1301666188-11822-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/stargate2.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index cb5611d..3e3621d 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -956,13 +956,7 @@ static struct i2c_board_info __initdata stargate2_i2c_board_info[] = {
 /* Board doesn't support cable detection - so always lie and say
  * something is there.
  */
-static int sg2_udc_detect(void)
-{
-	return 1;
-}
-
 static struct pxa2xx_udc_mach_info stargate2_udc_info __initdata = {
-	.udc_is_connected	= sg2_udc_detect,
 	.udc_command		= sg2_udc_command,
 };
 
-- 
1.7.4.1
