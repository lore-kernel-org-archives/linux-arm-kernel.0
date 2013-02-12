From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 17:28:49 +0100
Subject: [PATCH 15/32] arm: mach-mvebu: use ORION_ADDR_MAP_NO_REMAP
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1360686546-24277-16-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the addr_map_info structure uses an "int remap" to allow
SoC-specific code to specify whether a given address decoding window
should be remapped, and if so, the remapping address. To do so, it
tests if the int is less than zero (no remap) or greater than
zero. Unfortunately, this prevents any remapping address that is
higher than 2 GB.

In this commit, we convert mach-mvebu addr_map_info definition to use
ORION_ADDR_MAP_NO_REMAP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/addr-map.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/addr-map.c b/arch/arm/mach-mvebu/addr-map.c
index ab9b3bd..77c807b 100644
--- a/arch/arm/mach-mvebu/addr-map.c
+++ b/arch/arm/mach-mvebu/addr-map.c
@@ -42,7 +42,7 @@ armada_xp_addr_map_info[] = {
 	 * Window for the BootROM, needed for SMP on Armada XP
 	 */
 	{ 0, 0xfff00000, SZ_1M, ARMADA_XP_TARGET_DEV_BUS,
-	  ARMADA_XP_ATTR_DEV_BOOTROM, -1 },
+	  ARMADA_XP_ATTR_DEV_BOOTROM, ORION_ADDR_MAP_NO_REMAP },
 	/* End marker */
 	{ -1, 0, 0, 0, 0, 0 },
 };
-- 
1.7.9.5
