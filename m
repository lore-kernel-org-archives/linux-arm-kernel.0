From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Apr 2012 16:36:55 +0100
Subject: [PATCH] ARM: ux500: Fix build error caused by recent variable name
 change
Message-ID: <1335541015-10155-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

error: ?u8500_soc_node? undeclared (first use in this function)

Was recently changed to 'u8500_local_bus_nodes'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 39b4a98..bc8a0d7 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -761,7 +761,7 @@ static void __init u8500_init_machine(void)
 		snowball_platform_devs[i]->dev.parent = parent;
 
 	/* automatically probe child nodes of db8500 device */
-	of_platform_populate(NULL, u8500_soc_node, u8500_auxdata_lookup, parent);
+	of_platform_populate(NULL, u8500_local_bus_nodes, u8500_auxdata_lookup, parent);
 
 	if (of_machine_is_compatible("st-ericsson,mop500")) {
 		mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
-- 
1.7.9.1
