From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 15:03:03 +0800
Subject: [PATCH 09/11] ARM: imx6q: add ssi1 clk_lookup
In-Reply-To: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1335510185-7906-10-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's used by audio drivers.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index f40a35d..9a03dcc 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -418,6 +418,7 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[sdma], NULL, "20ec000.sdma");
 	clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
 	clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
+	clk_register_clkdev(clk[ssi1], NULL, "2028000.ssi");
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++) {
 		c = clk_get_sys(clks_init_on[i], NULL);
-- 
1.7.5.4
