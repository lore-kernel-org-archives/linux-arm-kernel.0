From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:36:56 +0900
Subject: [GIT PULL 2/2] ARM: shmobile: lager: add missing __initdata
In-Reply-To: <cover.1375842006.git.horms+renesas@verge.net.au>
References: <cover.1375842006.git.horms+renesas@verge.net.au>
Message-ID: <8c8881b50691e17864cc54e5824b140e62fc2035.1375842006.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds missing __initdata to driver data/resource
which are used from platform_device_register_xxx()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 3c67b2a..9489314 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -82,11 +82,11 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[] =
 };
 
 /* MMCIF */
-static struct sh_mmcif_plat_data mmcif1_pdata = {
+static struct sh_mmcif_plat_data mmcif1_pdata __initdata = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
 };
 
-static struct resource mmcif1_resources[] = {
+static struct resource mmcif1_resources[] __initdata = {
 	DEFINE_RES_MEM_NAMED(0xee220000, 0x80, "MMCIF1"),
 	DEFINE_RES_IRQ(gic_spi(170)),
 };
-- 
1.8.3.2
