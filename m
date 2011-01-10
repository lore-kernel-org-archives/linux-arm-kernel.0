From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 10 Jan 2011 23:53:10 +0100
Subject: [PATCH 2/5 resend] pxa: Remove unused variable in clock-pxa3xx.c
In-Reply-To: <1294699993-4712-1-git-send-email-marek.vasut@gmail.com>
References: <1294699993-4712-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1294699993-4712-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/clock-pxa3xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/clock-pxa3xx.c b/arch/arm/mach-pxa/clock-pxa3xx.c
index 1b08a34..3f864cd 100644
--- a/arch/arm/mach-pxa/clock-pxa3xx.c
+++ b/arch/arm/mach-pxa/clock-pxa3xx.c
@@ -115,7 +115,6 @@ static unsigned long clk_pxa3xx_smemc_getrate(struct clk *clk)
 {
 	unsigned long acsr = ACSR;
 	unsigned long memclkcfg = __raw_readl(MEMCLKCFG);
-	unsigned int smcfs = (acsr >> 23) & 0x7;
 
 	return BASE_CLK * smcfs_mult[(acsr >> 23) & 0x7] /
 			df_clkdiv[(memclkcfg >> 16) & 0x3];
-- 
1.7.2.3
