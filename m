From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 17:28:46 +0100
Subject: [PATCH 12/32] plat-orion: introduce ORION_ADDR_MAP_NO_REMAP
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1360686546-24277-13-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the addr_map_info structure uses an "int remap" to allow
SoC-specific code to specify whether a given address decoding window
should be remapped, and if so, the remapping address. To do so, it
tests if the int is less than zero (no remap) or greater than
zero. Unfortunately, this prevents any remapping address that is
higher than 2 GB.

As a first step to fix this, we introduce ORION_ADDR_MAP_NO_REMAP
define, that will be the "remap" value that SoC-specific code should
pass to not have a remapping.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/include/plat/addr-map.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
index b76c065..0861b8c 100644
--- a/arch/arm/plat-orion/include/plat/addr-map.h
+++ b/arch/arm/plat-orion/include/plat/addr-map.h
@@ -41,6 +41,8 @@ struct orion_addr_map_info {
 	const int remap;
 };
 
+#define ORION_ADDR_MAP_NO_REMAP (-1)
+
 void __init orion_config_wins(struct orion_addr_map_cfg *cfg,
 			      const struct orion_addr_map_info *info);
 
-- 
1.7.9.5
