From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Mar 2010 11:28:42 +0100
Subject: [PATCH 2/5] i.MX51: Use correct clock for gpt
In-Reply-To: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
References: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1268994525-32495-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpt uses the ipg clock, not ipg_perclk

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/clock-mx51.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index be90c03..8f85f73 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -757,7 +757,7 @@ DEFINE_CLOCK(uart3_ipg_clk, 2, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG7_OFFSET,
 
 /* GPT */
 DEFINE_CLOCK(gpt_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG9_OFFSET,
-	NULL,  NULL, &ipg_perclk, NULL);
+	NULL,  NULL, &ipg_clk, NULL);
 DEFINE_CLOCK(gpt_ipg_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG10_OFFSET,
 	NULL,  NULL, &ipg_clk, NULL);
 
-- 
1.7.0
