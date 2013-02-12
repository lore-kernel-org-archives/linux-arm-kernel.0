From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 17:28:50 +0100
Subject: [PATCH 16/32] arm: mach-orion5x: use ORION_ADDR_MAP_NO_REMAP
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1360686546-24277-17-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the addr_map_info structure uses an "int remap" to allow
SoC-specific code to specify whether a given address decoding window
should be remapped, and if so, the remapping address. To do so, it
tests if the int is less than zero (no remap) or greater than
zero. Unfortunately, this prevents any remapping address that is
higher than 2 GB.

In this commit, we convert mach-orion5x addr_map_info definition to
use ORION_ADDR_MAP_NO_REMAP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-orion5x/addr-map.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-orion5x/addr-map.c b/arch/arm/mach-orion5x/addr-map.c
index b5efc0f..4b80206 100644
--- a/arch/arm/mach-orion5x/addr-map.c
+++ b/arch/arm/mach-orion5x/addr-map.c
@@ -93,10 +93,10 @@ static const struct __initdata orion_addr_map_info addr_map_info[] = {
 	  TARGET_PCI, ATTR_PCI_IO, ORION5X_PCI_IO_BUS_BASE
 	},
 	{ 2, ORION5X_PCIE_MEM_PHYS_BASE, ORION5X_PCIE_MEM_SIZE,
-	  TARGET_PCIE, ATTR_PCIE_MEM, -1
+	  TARGET_PCIE, ATTR_PCIE_MEM, ORION_ADDR_MAP_NO_REMAP,
 	},
 	{ 3, ORION5X_PCI_MEM_PHYS_BASE, ORION5X_PCI_MEM_SIZE,
-	  TARGET_PCI, ATTR_PCI_MEM, -1
+	  TARGET_PCI, ATTR_PCI_MEM, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/* End marker */
 	{ -1, 0, 0, 0, 0, 0 }
-- 
1.7.9.5
