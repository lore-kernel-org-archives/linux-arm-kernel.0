From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  3 Aug 2012 15:10:28 +0200
Subject: [PATCH 2/4] arm: plat-orion: make bridge_virt_base non-const to
 support DT use case
In-Reply-To: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1343999430-31816-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the Armada 370 and XP SoCs where the DT is used, we need to fill
at runtime the bridge_virt_base field on the
orion_addr_map_cfg. Therefore, remove the 'const' qualifier on this
field.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/include/plat/addr-map.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
index fd556f7..aafdd79 100644
--- a/arch/arm/plat-orion/include/plat/addr-map.h
+++ b/arch/arm/plat-orion/include/plat/addr-map.h
@@ -16,7 +16,7 @@ extern struct mbus_dram_target_info orion_mbus_dram_info;
 struct orion_addr_map_cfg {
 	const int num_wins;	/* Total number of windows */
 	const int remappable_wins;
-	const u32 bridge_virt_base;
+	u32 bridge_virt_base;
 
 	/* If NULL, the default cpu_win_can_remap will be used, using
 	   the value in remappable_wins */
-- 
1.7.9.5
