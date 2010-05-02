From: saeed@marvell.com (Saeed Bishara)
Date: Sun,  2 May 2010 17:22:39 +0300
Subject: [PATCH 2/5] ARM: use the Dove USB phy setup
In-Reply-To: <1272810162-14858-2-git-send-email-saeed@marvell.com>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
	<1272810162-14858-2-git-send-email-saeed@marvell.com>
Message-ID: <1272810162-14858-3-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch makes the dove SoC use the proper USB phy setup.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mach-dove/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 5da2cf4..a83069c 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -74,7 +74,7 @@ void __init dove_map_io(void)
  ****************************************************************************/
 static struct orion_ehci_data dove_ehci_data = {
 	.dram		= &dove_mbus_dram_info,
-	.phy_version	= EHCI_PHY_NA,
+	.phy_version	= EHCI_PHY_DOVE,
 };
 
 static u64 ehci_dmamask = DMA_BIT_MASK(32);
-- 
1.6.0.4
