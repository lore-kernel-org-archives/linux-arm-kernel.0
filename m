From: sourav.poddar@ti.com (Sourav Poddar)
Date: Thu, 8 May 2014 11:30:06 +0530
Subject: [PATCHv2 3/5] arm: omap2: skip device build from platform code for dt.
In-Reply-To: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
References: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <1399528808-6920-4-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For SOCs with dt enabled, device should be build through device tree.
Prevent device build call from platform code, if device tree is
enabled.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/mach-omap2/hdq1w.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
index cbc8e3c..f78b4a1 100644
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -76,6 +76,7 @@ int omap_hdq1w_reset(struct omap_hwmod *oh)
 	return 0;
 }
 
+#ifndef CONFIG_OF
 static int __init omap_init_hdq(void)
 {
 	int id = -1;
@@ -95,3 +96,4 @@ static int __init omap_init_hdq(void)
 	return 0;
 }
 omap_arch_initcall(omap_init_hdq);
+#endif
-- 
1.7.9.5
