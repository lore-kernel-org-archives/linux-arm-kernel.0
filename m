From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 18 Jan 2013 21:02:19 +0530
Subject: [PATCH 3/5] ARM: OMAP: prm: Allow prm init to success on OMAP5 SOCs
In-Reply-To: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
References: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1358523141-12295-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow prm init to success on OMAP5 SOCs.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index c05a343..1aae198 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -650,7 +650,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(void)
 {
-	if (!cpu_is_omap44xx())
+	if (!cpu_is_omap44xx() && !soc_is_omap54xx())
 		return 0;
 
 	return prm_register(&omap44xx_prm_ll_data);
-- 
1.7.9.5
