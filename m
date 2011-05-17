From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue, 17 May 2011 17:41:59 -0400
Subject: [PATCH 3/9] davinci: da850: remove the SRAM_VIRT iotable entry
In-Reply-To: <cover.1305668470.git.bengardiner@nanometrics.ca>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
Message-ID: <67f7f28015746c1fe0ecef925e8f14d44df1b084.1305668470.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sram region defined for da850 in the iotable entry removed is also
defined in its davinci_soc_info, davinci_soc_info_da850 in da850.c.

Remove this duplicate information which is now uneccessary since sram
init will ioremap the region defined by davinci_soc_info_da850.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 arch/arm/mach-davinci/da850.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 09f6c12..5754338 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -725,12 +725,6 @@ static struct map_desc da850_io_desc[] = {
 		.length		= DA8XX_CP_INTC_SIZE,
 		.type		= MT_DEVICE
 	},
-	{
-		.virtual	= SRAM_VIRT,
-		.pfn		= __phys_to_pfn(DA8XX_ARM_RAM_BASE),
-		.length		= SZ_8K,
-		.type		= MT_DEVICE
-	},
 };
 
 static u32 da850_psc_bases[] = { DA8XX_PSC0_BASE, DA8XX_PSC1_BASE };
-- 
1.7.4.1
