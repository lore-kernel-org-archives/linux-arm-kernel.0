From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:32 -0700
Subject: [PATCH 08/47] davinci: dm365: disable pulldowns for all MMC/SD1 pins.
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-9-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This patch disables internal pulldowns for all MMC/SD1
pins. Presently only MMCSD1_CMD pin's pull down is
disabled, but with this some MMC/SD cards do not get
detected on MMC/SD1 slot of the EVM.

The problem was reproducible with SanDisk 4GB SDHC card.

Reported-by: Stephane Bovagne <s-bovagne@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 8b7201e..2a9a252 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -213,7 +213,7 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 				IO_ADDRESS(DAVINCI_SYSTEM_MODULE_BASE + 0x7c);
 
 			/* Configure pull down control */
-			__raw_writel((__raw_readl(pupdctl1) & ~0x400),
+			__raw_writel((__raw_readl(pupdctl1) & ~0xfc0),
 					pupdctl1);
 
 			mmcsd1_resources[0].start = DM365_MMCSD1_BASE;
-- 
1.7.2.1
