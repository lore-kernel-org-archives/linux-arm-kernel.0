From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Tue, 8 Mar 2016 10:20:13 +0800
Subject: [PATCH v10 1/6] clk: hisilicon: export some hisilicon APIs to modules
In-Reply-To: <1457403618-18317-1-git-send-email-xuejiancheng@huawei.com>
References: <1457403618-18317-1-git-send-email-xuejiancheng@huawei.com>
Message-ID: <1457403618-18317-2-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change some arguments to constant type.
Export some hisilicon APIs to modules.

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 drivers/clk/hisilicon/clk.c | 23 +++++++++++++++--------
 drivers/clk/hisilicon/clk.h | 14 +++++++-------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 9f8e766..9b15adb 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -37,7 +37,7 @@
 
 static DEFINE_SPINLOCK(hisi_clk_lock);
 
-struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
+struct hisi_clock_data *hisi_clk_init(struct device_node *np,
 					     int nr_clks)
 {
 	struct hisi_clock_data *clk_data;
@@ -71,8 +71,9 @@ err_data:
 err:
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(hisi_clk_init);
 
-void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *clks,
+void hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
 					 int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
@@ -91,8 +92,9 @@ void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+EXPORT_SYMBOL_GPL(hisi_clk_register_fixed_rate);
 
-void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *clks,
+void hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *clks,
 					   int nums,
 					   struct hisi_clock_data *data)
 {
@@ -112,8 +114,9 @@ void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+EXPORT_SYMBOL_GPL(hisi_clk_register_fixed_factor);
 
-void __init hisi_clk_register_mux(struct hisi_mux_clock *clks,
+void hisi_clk_register_mux(const struct hisi_mux_clock *clks,
 				  int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
@@ -141,8 +144,9 @@ void __init hisi_clk_register_mux(struct hisi_mux_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+EXPORT_SYMBOL_GPL(hisi_clk_register_mux);
 
-void __init hisi_clk_register_divider(struct hisi_divider_clock *clks,
+void hisi_clk_register_divider(const struct hisi_divider_clock *clks,
 				      int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
@@ -170,8 +174,9 @@ void __init hisi_clk_register_divider(struct hisi_divider_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+EXPORT_SYMBOL_GPL(hisi_clk_register_divider);
 
-void __init hisi_clk_register_gate(struct hisi_gate_clock *clks,
+void hisi_clk_register_gate(const struct hisi_gate_clock *clks,
 				       int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
@@ -198,8 +203,9 @@ void __init hisi_clk_register_gate(struct hisi_gate_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+EXPORT_SYMBOL_GPL(hisi_clk_register_gate);
 
-void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
+void hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
 				       int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
@@ -226,8 +232,9 @@ void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+EXPORT_SYMBOL_GPL(hisi_clk_register_gate_sep);
 
-void __init hi6220_clk_register_divider(struct hi6220_divider_clock *clks,
+void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
 					int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index b56fbc1..20d64af 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -111,18 +111,18 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
 	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock);
 
 struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
-void hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *,
+void hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
 				int, struct hisi_clock_data *);
-void hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *,
+void hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
 				int, struct hisi_clock_data *);
-void hisi_clk_register_mux(struct hisi_mux_clock *, int,
+void hisi_clk_register_mux(const struct hisi_mux_clock *, int,
 				struct hisi_clock_data *);
-void hisi_clk_register_divider(struct hisi_divider_clock *,
+void hisi_clk_register_divider(const struct hisi_divider_clock *,
 				int, struct hisi_clock_data *);
-void hisi_clk_register_gate(struct hisi_gate_clock *,
+void hisi_clk_register_gate(const struct hisi_gate_clock *,
 				int, struct hisi_clock_data *);
-void hisi_clk_register_gate_sep(struct hisi_gate_clock *,
+void hisi_clk_register_gate_sep(const struct hisi_gate_clock *,
 				int, struct hisi_clock_data *);
-void hi6220_clk_register_divider(struct hi6220_divider_clock *,
+void hi6220_clk_register_divider(const struct hi6220_divider_clock *,
 				int, struct hisi_clock_data *);
 #endif	/* __HISI_CLK_H */
-- 
1.9.1
