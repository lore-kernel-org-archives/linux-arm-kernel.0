From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:30:00 -0700
Subject: [PATCH 36/47] omap: cleanup unused davinci mdio arch code
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-37-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

This patch removes davinci architecture code that has now been rendered
useless by the previous patches in the MDIO separation series.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 5dd1b73..5225df6 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -39,7 +39,6 @@
 
 #include "mux.h"
 
-#define AM35XX_EVM_PHY_MASK		(0xF)
 #define AM35XX_EVM_MDIO_FREQUENCY	(1000000)
 
 static struct mdio_platform_data am3517_evm_mdio_pdata = {
@@ -64,8 +63,6 @@ static struct platform_device am3517_mdio_device = {
 };
 
 static struct emac_platform_data am3517_evm_emac_pdata = {
-	.phy_mask	= AM35XX_EVM_PHY_MASK,
-	.mdio_max_freq	= AM35XX_EVM_MDIO_FREQUENCY,
 	.rmii_en	= 1,
 };
 
@@ -135,7 +132,6 @@ void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
 	pdata->ctrl_reg_offset		= AM35XX_EMAC_CNTRL_OFFSET;
 	pdata->ctrl_mod_reg_offset	= AM35XX_EMAC_CNTRL_MOD_OFFSET;
 	pdata->ctrl_ram_offset		= AM35XX_EMAC_CNTRL_RAM_OFFSET;
-	pdata->mdio_reg_offset		= AM35XX_EMAC_MDIO_OFFSET;
 	pdata->ctrl_ram_size		= AM35XX_EMAC_CNTRL_RAM_SIZE;
 	pdata->version			= EMAC_VERSION_2;
 	pdata->hw_ram_addr		= AM35XX_EMAC_HW_RAM_ADDR;
-- 
1.7.2.1
