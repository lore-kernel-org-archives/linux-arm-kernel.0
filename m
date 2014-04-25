From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:36:08 +0100
Subject: [PATCH 061/222] ARM: l2c: spear13xx: remove cache size override
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeQK-0007HE-KC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-spear/spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index dcb300443b66..c9897ea38980 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -46,7 +46,7 @@ void __init spear13xx_l2x0_init(void)
 	 */
 	writel_relaxed(0x221, VA_L2CC_BASE + L310_TAG_LATENCY_CTRL);
 	writel_relaxed(0x441, VA_L2CC_BASE + L310_DATA_LATENCY_CTRL);
-	l2x0_init(VA_L2CC_BASE, 0x30a60001, 0xfe00ffff);
+	l2x0_init(VA_L2CC_BASE, 0x30a00001, 0xfe0fffff);
 }
 
 /*
-- 
1.8.3.1
