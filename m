From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  2 Jul 2013 13:00:24 +0200
Subject: [PATCH v6 7/7] ARM: orion5x: remove legacy mv643xx_eth board setup
In-Reply-To: <1372762824-12202-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1372762824-12202-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1372762824-12202-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DT support for mv643xx_eth we do not need legacy platform_data
based setup for DT enabled boards. This patch removes eth setup
for all orion5x DT board files.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v5->v6:
- rebase for v3.11-rc1

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: netdev at vger.kernel.org
---
 arch/arm/mach-orion5x/edmini_v2-setup.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
index 1cecedc..7d316ed 100644
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
@@ -25,7 +25,6 @@
 #include <linux/irq.h>
 #include <linux/mbus.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
@@ -97,14 +96,6 @@ static struct platform_device edmini_v2_nor_flash = {
 };
 
 /*****************************************************************************
- * Ethernet
- ****************************************************************************/
-
-static struct mv643xx_eth_platform_data edmini_v2_eth_data = {
-	.phy_addr	= 8,
-};
-
-/*****************************************************************************
  * RTC 5C372a on I2C bus
  ****************************************************************************/
 
@@ -153,7 +144,6 @@ void __init edmini_v2_init(void)
 	 * Configure peripherals.
 	 */
 	orion5x_ehci0_init();
-	orion5x_eth_init(&edmini_v2_eth_data);
 
 	mvebu_mbus_add_window("devbus-boot", EDMINI_V2_NOR_BOOT_BASE,
 			      EDMINI_V2_NOR_BOOT_SIZE);
-- 
1.7.2.5
