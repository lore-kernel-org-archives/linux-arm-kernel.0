From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue, 17 May 2011 17:42:00 -0400
Subject: [PATCH 4/9] davinci: dm355: remove the SRAM_VIRT iotable entry
In-Reply-To: <cover.1305668470.git.bengardiner@nanometrics.ca>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
Message-ID: <5bdebaf5036b59a247604b72f83e6cb1c35db4c2.1305668470.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sram region defined for dm355 in the iotable entry removed is also
defined in its davinci_soc_info, davinci_soc_info_dm355 in dm355.c.

Remove this duplicate information which is now uneccessary since sram
init will ioremap the region defined by davinci_soc_info_dm355.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 arch/arm/mach-davinci/dm355.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9bda687..94f44d3 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -757,12 +757,6 @@ static struct map_desc dm355_io_desc[] = {
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
 
 /* Contents of JTAG ID register used to identify exact cpu type */
-- 
1.7.4.1
