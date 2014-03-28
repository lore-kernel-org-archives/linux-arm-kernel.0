From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 28 Mar 2014 14:05:28 +0530
Subject: [PATCH 1/2] ARM: OMAP2+: L2 cache: use macro instead of const number
Message-ID: <5ea7277c21215c7b4aa776d5379dc2d6263228c6.1395994759.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Afzal Mohammed <afzal@ti.com>

Its better to use the available macro than 0x1.
No functional change.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
This series applies to latest of linux-next/master

 arch/arm/mach-omap2/omap4-common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 95e171a..8f18460 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -219,7 +219,7 @@ static int __init omap_l2_cache_init(void)
 		omap_smc1(0x109, aux_ctrl);
 
 	/* Enable PL310 L2 Cache controller */
-	omap_smc1(0x102, 0x1);
+	omap_smc1(0x102, L2X0_CTRL_EN);
 
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
-- 
1.7.10.1
