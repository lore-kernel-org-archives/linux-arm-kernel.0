From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Tue, 21 Dec 2010 17:23:34 +0530
Subject: [PATCH] ux500: remove unnecessary barrier from the secondary startup
Message-ID: <1292932414-21714-1-git-send-email-srinidhi.kasagar@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/mach-ux500/headsmp.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/headsmp.S b/arch/arm/mach-ux500/headsmp.S
index a6be2cd..64fa451 100644
--- a/arch/arm/mach-ux500/headsmp.S
+++ b/arch/arm/mach-ux500/headsmp.S
@@ -23,7 +23,6 @@ ENTRY(u8500_secondary_startup)
 	ldmia	r4, {r5, r6}
 	sub	r4, r4, r5
 	add	r6, r6, r4
-	dsb
 pen:	ldr	r7, [r6]
 	cmp	r7, r0
 	bne	pen
-- 
1.7.2.dirty
