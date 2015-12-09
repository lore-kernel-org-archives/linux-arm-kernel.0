From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed,  9 Dec 2015 17:04:10 +0800
Subject: [PATCH v1 5/8] clk: rockchip: allow more than 2 parents for cpuclk
In-Reply-To: <1449651853-1667-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1449651853-1667-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1449651853-1667-6-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3228's armclk has 3 parents, so allow cpuclk to have
more than 2 parents.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/clk/rockchip/clk-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 330870a..d07374f 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -242,8 +242,8 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 	struct clk *clk, *cclk;
 	int ret;
 
-	if (num_parents != 2) {
-		pr_err("%s: needs two parent clocks\n", __func__);
+	if (num_parents < 2) {
+		pr_err("%s: needs@least two parent clocks\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.1.4
