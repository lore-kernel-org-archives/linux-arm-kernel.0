From: mturquette@ti.com (Mike Turquette)
Date: Tue, 13 Dec 2011 20:11:57 -0800
Subject: [PATCH 6/7] omap: dss: use clk_prepare in dss reset
In-Reply-To: <1323835918-2371-1-git-send-email-mturquette@ti.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Message-ID: <1323835918-2371-7-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/display.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index dce9905..21f8fcc 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -297,8 +297,10 @@ int omap_dss_reset(struct omap_hwmod *oh)
 	}
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
-		if (oc->_clk)
+		if (oc->_clk) {
+			clk_prepare(oc->_clk);
 			clk_enable(oc->_clk);
+		}
 
 	dispc_disable_outputs();
 
-- 
1.7.5.4
