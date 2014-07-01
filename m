From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  1 Jul 2014 16:12:12 +0200
Subject: [PATCH 03/33] clk: at91: main: warn when the main crystal frequency
 is not set
In-Reply-To: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404223962-30471-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the main crystal frequency is not set, the main clock is approximated using
the MAINF value in the CKGR_MCFR register. Warn the user in that case.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/clk-main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 733306131b99..59fa3cc96c9e 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -388,6 +388,7 @@ static unsigned long clk_main_recalc_rate(struct at91_pmc *pmc,
 	if (parent_rate)
 		return parent_rate;
 
+	pr_warn("Main crystal frequency not set, using approximate value\n");
 	tmp = pmc_read(pmc, AT91_CKGR_MCFR);
 	if (!(tmp & AT91_PMC_MAINRDY))
 		return 0;
-- 
1.9.1
