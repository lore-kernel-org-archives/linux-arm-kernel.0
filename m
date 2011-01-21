From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Jan 2011 11:57:53 +0100
Subject: [PATCH 2/3] ARM i.MX28: use correct register for setting the rate
In-Reply-To: <1295607474-6559-1-git-send-email-s.hauer@pengutronix.de>
References: <1295607474-6559-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1295607474-6559-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_CLK_SET_RATE does not only handle the cpu clock but also other
clocks, so do not hardcode the HW_CLKCTRL_CPU register.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx28.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 4146b38..44acd9c 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -360,7 +360,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 			return -EINVAL;					\
 		}							\
 	}								\
-	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_CPU);		\
+	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##dr);		\
 									\
 	for (i = 10000; i; i--)						\
 		if (!(__raw_readl(CLKCTRL_BASE_ADDR +			\
-- 
1.7.2.3
