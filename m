From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 15 Nov 2011 14:47:57 +0800
Subject: [PATCH V4 02/14] ARM: mxc: time: add clk_prepare/clk_unprepare
In-Reply-To: <1321339689-25256-1-git-send-email-richard.zhao@linaro.org>
References: <1321339689-25256-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1321339689-25256-3-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's for migrating to generic clk framework API.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 4b0fe28..b4e8b18 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -292,7 +292,7 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 {
 	uint32_t tctl_val;
 
-	clk_enable(timer_clk);
+	clk_prepare_enable(timer_clk);
 
 	timer_base = base;
 
-- 
1.7.5.4
