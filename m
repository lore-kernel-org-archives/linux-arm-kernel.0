From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 11 Mar 2014 09:40:00 +0800
Subject: [PATCH 1/3] clk: hisi: assign missing clk to table
Message-ID: <1394502002-31058-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fixed rate and fixed factor clock isn't registered to clk table.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/clk/hisilicon/clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index a3a7152..18fc21f 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -68,6 +68,7 @@ void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *clks,
 			       __func__, clks[i].name);
 			continue;
 		}
+		clk_table[clks[i].id] = clk;
 	}
 }
 
@@ -87,6 +88,7 @@ void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *clks,
 			       __func__, clks[i].name);
 			continue;
 		}
+		clk_table[clks[i].id] = clk;
 	}
 }
 
-- 
1.8.3.2
