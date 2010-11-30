From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Tue, 30 Nov 2010 16:17:58 +0200
Subject: [PATCH] arm: omap2: io: fix clk_get() error check
Message-ID: <1291126678-2782-1-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_get() return value should be checked with IS_ERR().

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/io.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 40562dd..a1939b1 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -297,7 +297,7 @@ static int __init _omap2_init_reprogram_sdrc(void)
 		return 0;
 
 	dpll3_m2_ck = clk_get(NULL, "dpll3_m2_ck");
-	if (!dpll3_m2_ck)
+	if (IS_ERR(dpll3_m2_ck))
 		return -EINVAL;
 
 	rate = clk_get_rate(dpll3_m2_ck);
-- 
1.5.6.5
