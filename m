From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 22 Apr 2011 17:38:20 +0530
Subject: [PATCH v4 02/11] da850: add pruss clock.
In-Reply-To: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1303474109-6212-3-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PRUSS clock.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/da850.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 2d50885..a7cf2d0 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -238,6 +238,12 @@ static struct clk tptc2_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
+static struct clk pruss_clk = {
+	.name		= "pruss",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC0_PRUSS,
+};
+
 static struct clk uart0_clk = {
 	.name		= "uart0",
 	.parent		= &pll0_sysclk2,
@@ -401,6 +407,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"tpcc1",	&tpcc1_clk),
 	CLK(NULL,		"tptc2",	&tptc2_clk),
 	CLK(NULL,		"uart0",	&uart0_clk),
+	CLK(NULL,		"pruss",	&pruss_clk),
 	CLK(NULL,		"uart1",	&uart1_clk),
 	CLK(NULL,		"uart2",	&uart2_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
-- 
1.7.2.3
