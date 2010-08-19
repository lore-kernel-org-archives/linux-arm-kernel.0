From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 19 Aug 2010 15:38:39 +0900
Subject: [PATCH] ARM: S5PV210: Update I2C-1 Clock Register Property.
Message-ID: <1282199919-32523-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_GATE_IP3[8] is RESERVED. The port "I2C_HDMI_DDY" of
CLK_GATE_IP3[10] is used as another I2C port (but not dedicated to HDMI
as if it is a general I2C port)

Therefore, we define the unused I2C-1 (IP3[8] is not used) as another
I2C there was left undefined but used.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index af91fef..825b868 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -357,7 +357,7 @@ static struct clk init_clocks_disable[] = {
 		.id		= 1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<8),
+		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "i2c",
 		.id		= 2,
-- 
1.6.3.3
