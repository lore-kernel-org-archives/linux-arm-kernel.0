From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Sep 2016 16:06:23 +0200
Subject: [PATCH 4/4] ARM: orion5x: remove extraneous NO_IRQ
In-Reply-To: <20160906140623.2853066-1-arnd@arndb.de>
References: <20160906140623.2853066-1-arnd@arndb.de>
Message-ID: <20160906140623.2853066-4-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rd88f6183ap-ge passes NO_IRQ as the interrupt line for its m25p80
NOR flash. However, this device never uses an interrupt and the
driver doesn't care, so we can simply remove the deprecated constant
here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 4bf80dd5478c..8ffaead76771 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -71,7 +71,6 @@ static struct spi_board_info __initdata rd88f6183ap_ge_spi_slave_info[] = {
 	{
 		.modalias	= "m25p80",
 		.platform_data	= &rd88f6183ap_ge_spi_slave_data,
-		.irq		= NO_IRQ,
 		.max_speed_hz	= 20000000,
 		.bus_num	= 0,
 		.chip_select	= 0,
-- 
2.9.0
