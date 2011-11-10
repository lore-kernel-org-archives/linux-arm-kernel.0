From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 12:54:06 +0800
Subject: [PATCH 1/9] ARM: mxc: time: convert to clk_prepare/clk_unprepare
Message-ID: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/time.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 4b0fe28..5fa0cc4 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -292,6 +292,7 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 {
 	uint32_t tctl_val;
 
+	clk_prepare(timer_clk);
 	clk_enable(timer_clk);
 
 	timer_base = base;
-- 
1.7.5.4
