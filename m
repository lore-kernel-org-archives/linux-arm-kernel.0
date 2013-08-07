From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:38 +0900
Subject: [GIT PULL 21/26] ARM: shmobile: bockw: add missing __initdata
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <8c23c7caeb5750fcf6d7a0258692071b06fdc772.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds missing __initdata to driver data/resource
which are used from platform_device_register_xxx()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index b40885de..0dd2b90 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -67,14 +67,14 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
 };
 
-static struct smsc911x_platform_config smsc911x_data = {
+static struct smsc911x_platform_config smsc911x_data __initdata = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
 	.flags		= SMSC911X_USE_32BIT,
 	.phy_interface	= PHY_INTERFACE_MODE_MII,
 };
 
-static struct resource smsc911x_resources[] = {
+static struct resource smsc911x_resources[] __initdata = {
 	DEFINE_RES_MEM(0x18300000, 0x1000),
 	DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
 };
@@ -88,7 +88,7 @@ static struct resource usb_phy_resources[] __initdata = {
 static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
 
 /* SDHI */
-static struct sh_mobile_sdhi_info sdhi0_info = {
+static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
@@ -153,7 +153,7 @@ static struct resource mmc_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x5d)),
 };
 
-static struct sh_mmcif_plat_data sh_mmcif_plat = {
+static struct sh_mmcif_plat_data sh_mmcif_plat __initdata = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.caps		= MMC_CAP_4_BIT_DATA |
-- 
1.8.3.2
