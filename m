From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue, 17 May 2011 17:42:02 -0400
Subject: [PATCH 6/9] davinci: dm644x: remove the SRAM_VIRT iotable entry
In-Reply-To: <cover.1305668470.git.bengardiner@nanometrics.ca>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
Message-ID: <02ee65a4734240b16f6e9189c9aad4d0de39c8a9.1305668470.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sram region defined for dm644x in the iotable entry removed is also
defined in its davinci_soc_info, davinci_soc_info_dm644x in da644x.c.

Remove this duplicate information which is now uneccessary since sram
init will ioremap the region defined by davinci_soc_info_dm644x.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 arch/arm/mach-davinci/dm644x.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 3949ed7..11e6481 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -663,12 +663,6 @@ static struct map_desc dm644x_io_desc[] = {
 		.length		= IO_SIZE,
 		.type		= MT_DEVICE
 	},
-	{
-		.virtual	= SRAM_VIRT,
-		.pfn		= __phys_to_pfn(0x00008000),
-		.length		= SZ_16K,
-		.type		= MT_MEMORY_NONCACHED,
-	},
 };
 
 /* Contents of JTAG ID register used to identify exact cpu type */
-- 
1.7.4.1
