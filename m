From: bintian.wang@huawei.com (Bintian Wang)
Date: Fri, 29 May 2015 10:08:36 +0800
Subject: [PATCH v8 4/7] clk: hisilicon: Remove __init for marking function
 prototypes
In-Reply-To: <1432865319-20413-1-git-send-email-bintian.wang@huawei.com>
References: <1432865319-20413-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <1432865319-20413-5-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__init markings on function prototypes are useless, so remove
them.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Tyler Baker <tyler.baker@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/clk/hisilicon/clk.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 31083ff..6b6f994 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -95,17 +95,17 @@ struct clk *hisi_register_clkgate_sep(struct device *, const char *,
 				void __iomem *, u8,
 				u8, spinlock_t *);
 
-struct hisi_clock_data __init *hisi_clk_init(struct device_node *, int);
-void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *,
-					int, struct hisi_clock_data *);
-void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *,
-					int, struct hisi_clock_data *);
-void __init hisi_clk_register_mux(struct hisi_mux_clock *, int,
+struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
+void hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *,
+				int, struct hisi_clock_data *);
+void hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *,
+				int, struct hisi_clock_data *);
+void hisi_clk_register_mux(struct hisi_mux_clock *, int,
 				struct hisi_clock_data *);
-void __init hisi_clk_register_divider(struct hisi_divider_clock *,
+void hisi_clk_register_divider(struct hisi_divider_clock *,
+				int, struct hisi_clock_data *);
+void hisi_clk_register_gate(struct hisi_gate_clock *,
+				int, struct hisi_clock_data *);
+void hisi_clk_register_gate_sep(struct hisi_gate_clock *,
 				int, struct hisi_clock_data *);
-void __init hisi_clk_register_gate(struct hisi_gate_clock *,
-					int, struct hisi_clock_data *);
-void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *,
-					int, struct hisi_clock_data *);
 #endif	/* __HISI_CLK_H */
-- 
1.9.1
