From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:29 +0400
Subject: [PATCH 03/15] ARM: pxa/stargate2: drop udc_is_connected
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
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
1.7.5.4
