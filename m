From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 22 Aug 2013 16:36:38 +0900
Subject: [PATCH] ARM: shmobile: lager: Do not use register_type field of
 struct sh_eth_plat_data
Message-ID: <1377156998-15421-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of 8d3214c ("sh_eth: remove 'register_type' field from 'struct
sh_eth_plat_data'") is is no longer necessary or correct to use the
'register_type' field from 'struct sh_eth_plat_data' and doing so results
in a build error.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

Olof,

as discussed, please apply this to for-next and merge it upstream
after the patch mentioned above lands upstream via net-next.
---
 arch/arm/mach-shmobile/board-lager.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index a7e54e5..8f50ed2 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -96,7 +96,6 @@ static struct resource mmcif1_resources[] = {
 static struct sh_eth_plat_data ether_pdata __initdata = {
 	.phy			= 0x1,
 	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
-	.register_type		= SH_ETH_REG_FAST_RCAR,
 	.phy_interface		= PHY_INTERFACE_MODE_RMII,
 	.ether_link_active_low	= 1,
 };
-- 
1.8.3.2
