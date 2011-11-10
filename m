From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 12:54:09 +0800
Subject: [PATCH 4/9] ARM: mxc: epit: convert to clk_prepare/clk_unprepare
In-Reply-To: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
References: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320900854-13031-4-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/epit.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/epit.c b/arch/arm/plat-mxc/epit.c
index d3467f8..1520f38 100644
--- a/arch/arm/plat-mxc/epit.c
+++ b/arch/arm/plat-mxc/epit.c
@@ -203,6 +203,7 @@ static int __init epit_clockevent_init(struct clk *timer_clk)
 
 void __init epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 {
+	clk_prepare(timer_clk);
 	clk_enable(timer_clk);
 
 	timer_base = base;
-- 
1.7.5.4
