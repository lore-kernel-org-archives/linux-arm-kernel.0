From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:36:13 +0100
Subject: [PATCH 062/222] ARM: l2c: sti: remove cache size override
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeQP-0007HI-OC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sti/board-dt.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index dc8669efc12d..cf716ae10726 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -16,15 +16,9 @@
 
 void __init stih41x_l2x0_init(void)
 {
-	u32 way_size = 0x4;
-	u32 aux_ctrl;
-	/* may be this can be encoded in macros like BIT*() */
-	aux_ctrl = L2C_AUX_CTRL_SHARED_OVERRIDE |
-		   L310_AUX_CTRL_DATA_PREFETCH |
-		   L310_AUX_CTRL_INSTR_PREFETCH |
-		   L2C_AUX_CTRL_WAY_SIZE(way_size);
-
-	l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
+	l2x0_of_init(L2C_AUX_CTRL_SHARED_OVERRIDE |
+		     L310_AUX_CTRL_DATA_PREFETCH |
+		     L310_AUX_CTRL_INSTR_PREFETCH, 0xc00f0fff);
 }
 
 static void __init stih41x_machine_init(void)
-- 
1.8.3.1
