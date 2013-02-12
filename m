From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 17:28:48 +0100
Subject: [PATCH 14/32] arm: mach-kirkwood: use ORION_ADDR_MAP_NO_REMAP
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1360686546-24277-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the addr_map_info structure uses an "int remap" to allow
SoC-specific code to specify whether a given address decoding window
should be remapped, and if so, the remapping address. To do so, it
tests if the int is less than zero (no remap) or greater than
zero. Unfortunately, this prevents any remapping address that is
higher than 2 GB.

In this commit, we convert mach-kirkwood addr_map_info definition to
use ORION_ADDR_MAP_NO_REMAP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/addr-map.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/addr-map.c b/arch/arm/mach-kirkwood/addr-map.c
index 8f0d162..dc3a6d9 100644
--- a/arch/arm/mach-kirkwood/addr-map.c
+++ b/arch/arm/mach-kirkwood/addr-map.c
@@ -64,13 +64,13 @@ static const struct __initdata orion_addr_map_info addr_map_info[] = {
 	 * Window for NAND controller.
 	 */
 	{ 4, KIRKWOOD_NAND_MEM_PHYS_BASE, KIRKWOOD_NAND_MEM_SIZE,
-	  TARGET_DEV_BUS, ATTR_DEV_NAND, -1
+	  TARGET_DEV_BUS, ATTR_DEV_NAND, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/*
 	 * Window for SRAM.
 	 */
 	{ 5, KIRKWOOD_SRAM_PHYS_BASE, KIRKWOOD_SRAM_SIZE,
-	  TARGET_SRAM, ATTR_SRAM, -1
+	  TARGET_SRAM, ATTR_SRAM, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/* End marker */
 	{ -1, 0, 0, 0, 0, 0 }
-- 
1.7.9.5
