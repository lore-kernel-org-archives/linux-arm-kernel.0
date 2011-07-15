From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 15 Jul 2011 20:09:39 +0800
Subject: [PATCH v3 09/10] ARM: mxs: correct the using of frac div for saif
In-Reply-To: <1310731780-1645-1-git-send-email-b29396@freescale.com>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
Message-ID: <1310731780-1645-10-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to spec, set to 1 is the enable of fractional devide
or the clock can not be generated properly.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx28.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 7b3657b..7954013 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -710,11 +710,11 @@ static int clk_misc_init(void)
 
 	/* SAIF has to use frac div for functional operation */
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_SAIF0);
-	reg &= ~BM_CLKCTRL_SAIF0_DIV_FRAC_EN;
+	reg |= BM_CLKCTRL_SAIF0_DIV_FRAC_EN;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_SAIF0);
 
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_SAIF1);
-	reg &= ~BM_CLKCTRL_SAIF1_DIV_FRAC_EN;
+	reg |= BM_CLKCTRL_SAIF1_DIV_FRAC_EN;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_SAIF1);
 
 	/*
-- 
1.7.0.4
