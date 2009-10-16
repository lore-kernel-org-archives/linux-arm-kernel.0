From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:05 -0700
Subject: [PATCH 01/46] DaVinci: DM365: SDIO interrupt resource correction
In-Reply-To: <1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phaneendra Kumar <phani@embwise.com>

This patch fixes a typo/bug in the DM365 SDIO interrupt assignment

Signed-off-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index a55b650..34dc0e9 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -177,7 +177,7 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			mmcsd1_resources[0].start = DM365_MMCSD1_BASE;
 			mmcsd1_resources[0].end = DM365_MMCSD1_BASE +
 							SZ_4K - 1;
-			mmcsd0_resources[2].start = IRQ_DM365_SDIOINT1;
+			mmcsd1_resources[2].start = IRQ_DM365_SDIOINT1;
 		} else
 			break;
 
-- 
1.6.4.3
