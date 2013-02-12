From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 17:28:47 +0100
Subject: [PATCH 13/32] arm: mach-dove: use ORION_ADDR_MAP_NO_REMAP
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1360686546-24277-14-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the addr_map_info structure uses an "int remap" to allow
SoC-specific code to specify whether a given address decoding window
should be remapped, and if so, the remapping address. To do so, it
tests if the int is less than zero (no remap) or greater than
zero. Unfortunately, this prevents any remapping address that is
higher than 2 GB.

In this commit, we convert mach-dove addr_map_info definition to use
ORION_ADDR_MAP_NO_REMAP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/addr-map.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-dove/addr-map.c
index 2a06c01..febb4dc 100644
--- a/arch/arm/mach-dove/addr-map.c
+++ b/arch/arm/mach-dove/addr-map.c
@@ -61,28 +61,28 @@ static const struct __initdata orion_addr_map_info addr_map_info[] = {
 	  TARGET_PCIE1, ATTR_PCIE_IO, DOVE_PCIE1_IO_BUS_BASE
 	},
 	{ 2, DOVE_PCIE0_MEM_PHYS_BASE, DOVE_PCIE0_MEM_SIZE,
-	  TARGET_PCIE0, ATTR_PCIE_MEM, -1
+	  TARGET_PCIE0, ATTR_PCIE_MEM, ORION_ADDR_MAP_NO_REMAP,
 	},
 	{ 3, DOVE_PCIE1_MEM_PHYS_BASE, DOVE_PCIE1_MEM_SIZE,
-	  TARGET_PCIE1, ATTR_PCIE_MEM, -1
+	  TARGET_PCIE1, ATTR_PCIE_MEM, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/*
 	 * Window for CESA engine.
 	 */
 	{ 4, DOVE_CESA_PHYS_BASE, DOVE_CESA_SIZE,
-	  TARGET_CESA, ATTR_CESA, -1
+	  TARGET_CESA, ATTR_CESA, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/*
 	 * Window to the BootROM for Standby and Sleep Resume
 	 */
 	{ 5, DOVE_BOOTROM_PHYS_BASE, DOVE_BOOTROM_SIZE,
-	  TARGET_BOOTROM, ATTR_BOOTROM, -1
+	  TARGET_BOOTROM, ATTR_BOOTROM, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/*
 	 * Window to the PMU Scratch Pad space
 	 */
 	{ 6, DOVE_SCRATCHPAD_PHYS_BASE, DOVE_SCRATCHPAD_SIZE,
-	  TARGET_SCRATCHPAD, ATTR_SCRATCHPAD, -1
+	  TARGET_SCRATCHPAD, ATTR_SCRATCHPAD, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/* End marker */
 	{ -1, 0, 0, 0, 0, 0 }
-- 
1.7.9.5
