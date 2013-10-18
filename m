From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 18 Oct 2013 16:44:59 +0300
Subject: [PATCH v4 2/7] clk: tegra: Add periph regs bank X
In-Reply-To: <1382103904-6398-1-git-send-email-pdeschrijver@nvidia.com>
References: <1382103904-6398-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1382103904-6398-3-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra124 has an extra bank of peripheral clock registers. Add it to the
generic peripheral clock code.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 14d2532..a12a5f5 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -57,6 +57,8 @@
 #define RST_DEVICES_CLR_V		0x434
 #define RST_DEVICES_SET_W		0x438
 #define RST_DEVICES_CLR_W		0x43c
+#define RST_DEVICES_SET_X		0x290
+#define RST_DEVICES_CLR_X		0x294
 
 /* Global data of Tegra CPU CAR ops */
 static struct tegra_cpu_car_ops dummy_car_ops;
@@ -109,6 +111,14 @@ static struct tegra_clk_periph_regs periph_regs[] = {
 		.rst_set_reg = RST_DEVICES_SET_W,
 		.rst_clr_reg = RST_DEVICES_CLR_W,
 	},
+	[5] = {
+		.enb_reg = CLK_OUT_ENB_X,
+		.enb_set_reg = CLK_OUT_ENB_SET_X,
+		.enb_clr_reg = CLK_OUT_ENB_CLR_X,
+		.rst_reg = RST_DEVICES_X,
+		.rst_set_reg = RST_DEVICES_SET_X,
+		.rst_clr_reg = RST_DEVICES_CLR_X,
+	},
 };
 
 struct tegra_clk_periph_regs *get_reg_bank(int clkid)
-- 
1.7.7.rc0.72.g4b5ea.dirty
