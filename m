From: saeed@marvell.com (Saeed Bishara)
Date: Sun,  6 Jun 2010 15:28:56 +0300
Subject: [PATCH 2/2] set packet size limit for the mv643xx csum offloading
In-Reply-To: <1275827336-31111-1-git-send-email-saeed@marvell.com>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
Message-ID: <1275827336-31111-2-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv643xx ethernet controller limits the packet size for the TX
checksum offloading. this patch sets this limits for the needed
devices.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mach-dove/common.c     |    1 +
 arch/arm/mach-kirkwood/common.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 5da2cf4..473ce0b 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -149,6 +149,7 @@ void __init dove_ehci1_init(void)
 struct mv643xx_eth_shared_platform_data dove_ge00_shared_data = {
 	.t_clk		= 0,
 	.dram		= &dove_mbus_dram_info,
+	.tx_csum_limit	= 1600,
 };
 
 static struct resource dove_ge00_shared_resources[] = {
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 4ccfdf9..c4bd8cb 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -114,6 +114,7 @@ void __init kirkwood_ehci_init(void)
  ****************************************************************************/
 struct mv643xx_eth_shared_platform_data kirkwood_ge00_shared_data = {
 	.dram		= &kirkwood_mbus_dram_info,
+	.tx_csum_limit	= 1600,
 };
 
 static struct resource kirkwood_ge00_shared_resources[] = {
-- 
1.6.0.4
