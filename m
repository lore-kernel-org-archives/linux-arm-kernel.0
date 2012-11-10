From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 10 Nov 2012 12:13:46 +0530
Subject: [PATCH 7/8] CLK: SPEAr: Correct index scanning done for clock synths
In-Reply-To: <cover.1352529508.git.viresh.kumar@linaro.org>
References: <cover.1352529508.git.viresh.kumar@linaro.org>
Message-ID: <bdd2dd8d887d260355e21e605cab39fc0c8bd9be.1352529508.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Deepak Sikri <deepak.sikri@st.com>

The patch corrects the case when the rate table is being scanned for a
given frequency, and the search frequency is beyond the maximum
frequency indexed in the table.

By default, the system should be set at max frequency present in the
rate table. This patch correctly returns the corresponding index value.

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/spear/clk.c b/drivers/clk/spear/clk.c
index 7cd6378..628b6d5 100644
--- a/drivers/clk/spear/clk.c
+++ b/drivers/clk/spear/clk.c
@@ -32,5 +32,8 @@ long clk_round_rate_index(struct clk_hw *hw, unsigned long drate,
 		}
 	}
 
+	if ((*index) == rtbl_cnt)
+		(*index)--;
+
 	return rate;
 }
-- 
1.7.12.rc2.18.g61b472e
