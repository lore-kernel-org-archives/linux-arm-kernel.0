From: weber@corscience.de (Thomas Weber)
Date: Wed,  2 Jun 2010 13:37:51 +0200
Subject: [PATCHv2 11/11] OMAP2: Devkit8000: Fix regulator for power supply
In-Reply-To: <1275478671-24563-1-git-send-email-weber@corscience.de>
References: <1275478671-24563-1-git-send-email-weber@corscience.de>
Message-ID: <1275478671-24563-12-git-send-email-weber@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Devkit8000 uses the TPS65930 and not the TWL4030.
The TPS65930 uses only a subset of the power supplies
of the TWL4030.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index a485d39..648b565 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -380,7 +380,7 @@ static struct twl4030_platform_data devkit8000_twldata = {
 
 static struct i2c_board_info __initdata devkit8000_i2c_boardinfo[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("tps65930", 0x48),
 		.flags = I2C_CLIENT_WAKE,
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &devkit8000_twldata,
-- 
1.7.1
