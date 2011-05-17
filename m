From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue, 17 May 2011 17:42:01 -0400
Subject: [PATCH 5/9] davinci: dm365: remove the SRAM_VIRT iotable entry
In-Reply-To: <cover.1305668470.git.bengardiner@nanometrics.ca>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
Message-ID: <9d809a23414abb7619a7ac1bf49fdcac04251467.1305668470.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sram region defined for dm365 in the iotable entry removed is also
defined in its davinci_soc_info, davinci_soc_info_dm365 in dm365.c.

Remove this duplicate information which is now uneccessary since sram
init will ioremap the region defined by davinci_soc_info_dm365.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 arch/arm/mach-davinci/dm365.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index d306034..58f5b0a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -970,12 +970,6 @@ static struct map_desc dm365_io_desc[] = {
 		.length		= IO_SIZE,
 		.type		= MT_DEVICE
 	},
-	{
-		.virtual	= SRAM_VIRT,
-		.pfn		= __phys_to_pfn(0x00010000),
-		.length		= SZ_32K,
-		.type		= MT_MEMORY_NONCACHED,
-	},
 };
 
 static struct resource dm365_ks_resources[] = {
-- 
1.7.4.1
