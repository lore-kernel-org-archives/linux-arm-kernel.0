From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 5 Jun 2013 17:08:26 +0300
Subject: [PATCH 1/4] clk: tegra: Add fields for override bits
In-Reply-To: <1370441329-8619-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370441329-8619-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1370441329-8619-2-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLLM can have override bits in the PMC. Describe those in the PLL parameters.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index d70eb2d..e01ac46 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -136,6 +136,9 @@ struct pdiv_map {
  * @divm_width:	width of the input divider bit field
  * @divp_shift:	shift to the post divider bit field
  * @divp_width:	width of the post divider bit field
+ * @override_divn_shift: shift to the feedback divider bitfield in override reg
+ * @override_divm_shift: shift to the input divider bitfield in override reg
+ * @override_divp_shift: shift to the post divider bitfield in override reg
  */
 struct div_nmp {
 	u8		divn_shift;
@@ -144,6 +147,9 @@ struct div_nmp {
 	u8		divm_width;
 	u8		divp_shift;
 	u8		divp_width;
+	u8		override_divn_shift;
+	u8		override_divm_shift;
+	u8		override_divp_shift;
 };
 
 /**
@@ -180,6 +186,8 @@ struct tegra_clk_pll_params {
 	u32		aux_reg;
 	u32		dyn_ramp_reg;
 	u32		ext_misc_reg[3];
+	u32		pmc_divnm_reg;
+	u32		pmc_divp_reg;
 	int		stepa_shift;
 	int		stepb_shift;
 	int		lock_delay;
-- 
1.7.7.rc0.72.g4b5ea.dirty
