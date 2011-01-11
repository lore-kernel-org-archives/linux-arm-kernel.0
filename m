From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Tue, 11 Jan 2011 20:54:24 +0800
Subject: [PATCH v2 4/4] ARM: i.MX5: uart clock bug fix
In-Reply-To: <1294750464-8660-1-git-send-email-yong.shen@freescale.com>
References: <1294750464-8660-1-git-send-email-yong.shen@freescale.com>
Message-ID: <1294750464-8660-5-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

uart clk is from pll3 on mx53 instead of mx51

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index a20d0c0..3fb7ff8 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1370,7 +1370,6 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 
 	clk_tree_init();
 
-	clk_set_parent(&uart_root_clk, &pll3_sw_clk);
 	clk_enable(&cpu_clk);
 	clk_enable(&main_bus_clk);
 
@@ -1413,6 +1412,7 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 
 	clk_tree_init();
 
+	clk_set_parent(&uart_root_clk, &pll3_sw_clk);
 	clk_enable(&cpu_clk);
 	clk_enable(&main_bus_clk);
 
-- 
1.7.1
