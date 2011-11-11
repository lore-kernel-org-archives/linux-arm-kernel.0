From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 11 Nov 2011 09:10:20 +0800
Subject: [PATCH V2 05/14] ARM: mxc: epit: add clk_prepare/clk_unprepare
In-Reply-To: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
References: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320973829-4388-6-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/epit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/epit.c b/arch/arm/plat-mxc/epit.c
index d3467f8..9129c9e 100644
--- a/arch/arm/plat-mxc/epit.c
+++ b/arch/arm/plat-mxc/epit.c
@@ -203,7 +203,7 @@ static int __init epit_clockevent_init(struct clk *timer_clk)
 
 void __init epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 {
-	clk_enable(timer_clk);
+	clk_prepare_enable(timer_clk);
 
 	timer_base = base;
 
-- 
1.7.5.4
