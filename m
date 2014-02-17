From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Feb 2014 15:23:20 +0100
Subject: [PATCH v4 02/13] ARM: mvebu: rename DT machine structure for Armada
 370/XP
In-Reply-To: <1392647011-30117-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392647011-30117-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392647011-30117-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to a mistake made when merging Armada 370 and Armada XP DT machine
structures, the name of the structure was incorrectly chosen as being
ARMADA_XP_DT, while the structure also covers Armada 370. Therefore,
we rename the structure to ARMADA_370_XP_DT.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index fc2fb6e..84817fd 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -87,7 +87,7 @@ static const char * const armada_370_xp_dt_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 370/XP (Device Tree)")
+DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= mvebu_dt_init,
 	.map_io		= mvebu_map_io,
-- 
1.8.3.2
