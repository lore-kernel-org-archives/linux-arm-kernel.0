From: bintian.wang@huawei.com (Bintian Wang)
Date: Wed, 20 May 2015 18:29:10 +0800
Subject: [PATCH v7 5/7] clk: hisilicon: Remove __init for marking function
 prototypes
Message-ID: <1432117752-7074-1-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__init markings on function prototypes are useless, so remove
them.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
---
 drivers/clk/hisilicon/clk.h |   22 +++++++++++-----------
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
1.7.9.5
