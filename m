From: axel.lin@gmail.com (Axel Lin)
Date: Wed, 29 Jun 2011 21:33:57 +0800
Subject: [PATCH] mach-ux500: fix build error due to unknown 'regulator_en'
	field
Message-ID: <1309354437.10872.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix below build error:

  CC      arch/arm/mach-ux500/board-mop500-u8500uib.o
arch/arm/mach-ux500/board-mop500-u8500uib.c:35: error: unknown field 'regulator_en' specified in initializer
arch/arm/mach-ux500/board-mop500-u8500uib.c:35: warning: excess elements in struct initializer
arch/arm/mach-ux500/board-mop500-u8500uib.c:35: warning: (near initialization for 'rmi4_i2c_dev_platformdata')
make[1]: *** [arch/arm/mach-ux500/board-mop500-u8500uib.o] Error 1
make: *** [arch/arm/mach-ux500] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-ux500/board-mop500-u8500uib.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-u8500uib.c b/arch/arm/mach-ux500/board-mop500-u8500uib.c
index d8a8734..1af7228 100644
--- a/arch/arm/mach-ux500/board-mop500-u8500uib.c
+++ b/arch/arm/mach-ux500/board-mop500-u8500uib.c
@@ -32,7 +32,6 @@ static struct synaptics_rmi4_platform_data rmi4_i2c_dev_platformdata = {
 	.irq_type       = (IRQF_TRIGGER_FALLING | IRQF_SHARED),
 	.x_flip		= false,
 	.y_flip		= true,
-	.regulator_en   = false,
 };
 
 static struct i2c_board_info __initdata mop500_i2c3_devices_u8500[] = {
-- 
1.7.4.1
