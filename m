From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Thu, 22 Nov 2012 16:28:57 +0000
Subject: [PATCH] ARM: shmobile: r8a7779: Fix PFC - MOD_SEL2 missed an entry
Message-ID: <1353601737-21641-1-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The list of functions selected by the MOD_SEL2 register was missing
an entry. This caused all entries after this to modify the MOD_SEL2
register incorrectly.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/mach-shmobile/pfc-r8a7779.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-r8a7779.c b/arch/arm/mach-shmobile/pfc-r8a7779.c
index 9fac32e4..15f6a48 100644
--- a/arch/arm/mach-shmobile/pfc-r8a7779.c
+++ b/arch/arm/mach-shmobile/pfc-r8a7779.c
@@ -2525,7 +2525,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* SEL_SCIF [2] */
 	    FN_SEL_SCIF_0, FN_SEL_SCIF_1, FN_SEL_SCIF_2, FN_SEL_SCIF_3,
 	    /* SEL_CANCLK [2] */
-	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2,
+	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2, 0,
 	    /* SEL_CAN0 [1] */
 	    FN_SEL_CAN0_0, FN_SEL_CAN0_1,
 	    /* SEL_HSCIF1 [1] */
-- 
1.7.5.4
