From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 11:49:44 +0900
Subject: [PATCH 1/2] clk: samsung: exynos5260: Move struct samsung_cmu_info to
 init section
In-Reply-To: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
References: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471834185-20249-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the all samsung_cmu_info struct to initconst section
because they are used only in initconst section.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos5260.c | 350 +++++++++++++++++------------------
 1 file changed, 175 insertions(+), 175 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
index a43642c36039..fd1d9bfc151b 100644
--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -131,21 +131,21 @@ static const struct samsung_gate_clock aud_gate_clks[] __initconst = {
 			EN_IP_AUD, 4, 0, 0),
 };
 
+static const struct samsung_cmu_info aud_cmu __initconst = {
+	.mux_clks	= aud_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(aud_mux_clks),
+	.div_clks	= aud_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(aud_div_clks),
+	.gate_clks	= aud_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(aud_gate_clks),
+	.nr_clk_ids	= AUD_NR_CLK,
+	.clk_regs	= aud_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(aud_clk_regs),
+};
+
 static void __init exynos5260_clk_aud_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.mux_clks = aud_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(aud_mux_clks);
-	cmu.div_clks = aud_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(aud_div_clks);
-	cmu.gate_clks = aud_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(aud_gate_clks);
-	cmu.nr_clk_ids = AUD_NR_CLK;
-	cmu.clk_regs = aud_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(aud_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &aud_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_aud, "samsung,exynos5260-clock-aud",
@@ -321,21 +321,21 @@ static const struct samsung_gate_clock disp_gate_clks[] __initconst = {
 			EN_IP_DISP, 25, 0, 0),
 };
 
+static const struct samsung_cmu_info disp_cmu __initconst = {
+	.mux_clks	= disp_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(disp_mux_clks),
+	.div_clks	= disp_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(disp_div_clks),
+	.gate_clks	= disp_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(disp_gate_clks),
+	.nr_clk_ids	= DISP_NR_CLK,
+	.clk_regs	= disp_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(disp_clk_regs),
+};
+
 static void __init exynos5260_clk_disp_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.mux_clks = disp_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(disp_mux_clks);
-	cmu.div_clks = disp_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(disp_div_clks);
-	cmu.gate_clks = disp_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(disp_gate_clks);
-	cmu.nr_clk_ids = DISP_NR_CLK;
-	cmu.clk_regs = disp_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(disp_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &disp_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_disp, "samsung,exynos5260-clock-disp",
@@ -385,21 +385,21 @@ static const struct samsung_pll_clock egl_pll_clks[] __initconst = {
 		pll2550_24mhz_tbl),
 };
 
+static const struct samsung_cmu_info egl_cmu __initconst = {
+	.pll_clks	= egl_pll_clks,
+	.nr_pll_clks	= ARRAY_SIZE(egl_pll_clks),
+	.mux_clks	= egl_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(egl_mux_clks),
+	.div_clks	= egl_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(egl_div_clks),
+	.nr_clk_ids	= EGL_NR_CLK,
+	.clk_regs	= egl_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(egl_clk_regs),
+};
+
 static void __init exynos5260_clk_egl_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.pll_clks = egl_pll_clks;
-	cmu.nr_pll_clks =  ARRAY_SIZE(egl_pll_clks);
-	cmu.mux_clks = egl_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(egl_mux_clks);
-	cmu.div_clks = egl_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(egl_div_clks);
-	cmu.nr_clk_ids = EGL_NR_CLK;
-	cmu.clk_regs = egl_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(egl_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &egl_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_egl, "samsung,exynos5260-clock-egl",
@@ -487,19 +487,19 @@ static const struct samsung_gate_clock fsys_gate_clks[] __initconst = {
 			EN_IP_FSYS_SECURE_SMMU_RTIC, 12, 0, 0),
 };
 
+static const struct samsung_cmu_info fsys_cmu __initconst = {
+	.mux_clks	= fsys_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(fsys_mux_clks),
+	.gate_clks	= fsys_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(fsys_gate_clks),
+	.nr_clk_ids	= FSYS_NR_CLK,
+	.clk_regs	= fsys_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(fsys_clk_regs),
+};
+
 static void __init exynos5260_clk_fsys_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.mux_clks = fsys_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(fsys_mux_clks);
-	cmu.gate_clks = fsys_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(fsys_gate_clks);
-	cmu.nr_clk_ids = FSYS_NR_CLK;
-	cmu.clk_regs = fsys_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(fsys_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &fsys_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_fsys, "samsung,exynos5260-clock-fsys",
@@ -576,21 +576,21 @@ static const struct samsung_gate_clock g2d_gate_clks[] __initconst = {
 			EN_IP_G2D_SECURE_SMMU_G2D, 15, 0, 0),
 };
 
+static const struct samsung_cmu_info g2d_cmu __initconst = {
+	.mux_clks	= g2d_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(g2d_mux_clks),
+	.div_clks	= g2d_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(g2d_div_clks),
+	.gate_clks	= g2d_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(g2d_gate_clks),
+	.nr_clk_ids	= G2D_NR_CLK,
+	.clk_regs	= g2d_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(g2d_clk_regs),
+};
+
 static void __init exynos5260_clk_g2d_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.mux_clks = g2d_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(g2d_mux_clks);
-	cmu.div_clks = g2d_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(g2d_div_clks);
-	cmu.gate_clks = g2d_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(g2d_gate_clks);
-	cmu.nr_clk_ids = G2D_NR_CLK;
-	cmu.clk_regs = g2d_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(g2d_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &g2d_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_g2d, "samsung,exynos5260-clock-g2d",
@@ -637,23 +637,23 @@ static const struct samsung_pll_clock g3d_pll_clks[] __initconst = {
 		pll2550_24mhz_tbl),
 };
 
+static const struct samsung_cmu_info g3d_cmu __initconst = {
+	.pll_clks	= g3d_pll_clks,
+	.nr_pll_clks	= ARRAY_SIZE(g3d_pll_clks),
+	.mux_clks	= g3d_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(g3d_mux_clks),
+	.div_clks	= g3d_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(g3d_div_clks),
+	.gate_clks	= g3d_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(g3d_gate_clks),
+	.nr_clk_ids	= G3D_NR_CLK,
+	.clk_regs	= g3d_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(g3d_clk_regs),
+};
+
 static void __init exynos5260_clk_g3d_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.pll_clks = g3d_pll_clks;
-	cmu.nr_pll_clks =  ARRAY_SIZE(g3d_pll_clks);
-	cmu.mux_clks = g3d_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(g3d_mux_clks);
-	cmu.div_clks = g3d_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(g3d_div_clks);
-	cmu.gate_clks = g3d_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(g3d_gate_clks);
-	cmu.nr_clk_ids = G3D_NR_CLK;
-	cmu.clk_regs = g3d_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(g3d_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &g3d_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_g3d, "samsung,exynos5260-clock-g3d",
@@ -772,21 +772,21 @@ static const struct samsung_gate_clock gscl_gate_clks[] __initconst = {
 			EN_IP_GSCL_SECURE_SMMU_MSCL1, 20, 0, 0),
 };
 
+static const struct samsung_cmu_info gscl_cmu __initconst = {
+	.mux_clks	= gscl_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(gscl_mux_clks),
+	.div_clks	= gscl_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(gscl_div_clks),
+	.gate_clks	= gscl_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(gscl_gate_clks),
+	.nr_clk_ids	= GSCL_NR_CLK,
+	.clk_regs	= gscl_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(gscl_clk_regs),
+};
+
 static void __init exynos5260_clk_gscl_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.mux_clks = gscl_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(gscl_mux_clks);
-	cmu.div_clks = gscl_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(gscl_div_clks);
-	cmu.gate_clks = gscl_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(gscl_gate_clks);
-	cmu.nr_clk_ids = GSCL_NR_CLK;
-	cmu.clk_regs = gscl_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(gscl_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &gscl_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_gscl, "samsung,exynos5260-clock-gscl",
@@ -891,21 +891,21 @@ static const struct samsung_gate_clock isp_gate_clks[] __initconst = {
 			EN_SCLK_ISP, 9, CLK_SET_RATE_PARENT, 0),
 };
 
+static const struct samsung_cmu_info isp_cmu __initconst = {
+	.mux_clks	= isp_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(isp_mux_clks),
+	.div_clks	= isp_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(isp_div_clks),
+	.gate_clks	= isp_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(isp_gate_clks),
+	.nr_clk_ids	= ISP_NR_CLK,
+	.clk_regs	= isp_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(isp_clk_regs),
+};
+
 static void __init exynos5260_clk_isp_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.mux_clks = isp_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(isp_mux_clks);
-	cmu.div_clks = isp_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(isp_div_clks);
-	cmu.gate_clks = isp_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(isp_gate_clks);
-	cmu.nr_clk_ids = ISP_NR_CLK;
-	cmu.clk_regs = isp_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(isp_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &isp_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_isp, "samsung,exynos5260-clock-isp",
@@ -955,21 +955,21 @@ static const struct samsung_pll_clock kfc_pll_clks[] __initconst = {
 		pll2550_24mhz_tbl),
 };
 
+static const struct samsung_cmu_info kfc_cmu __initconst = {
+	.pll_clks	= kfc_pll_clks,
+	.nr_pll_clks	= ARRAY_SIZE(kfc_pll_clks),
+	.mux_clks	= kfc_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(kfc_mux_clks),
+	.div_clks	= kfc_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(kfc_div_clks),
+	.nr_clk_ids	= KFC_NR_CLK,
+	.clk_regs	= kfc_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(kfc_clk_regs),
+};
+
 static void __init exynos5260_clk_kfc_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.pll_clks = kfc_pll_clks;
-	cmu.nr_pll_clks =  ARRAY_SIZE(kfc_pll_clks);
-	cmu.mux_clks = kfc_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(kfc_mux_clks);
-	cmu.div_clks = kfc_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(kfc_div_clks);
-	cmu.nr_clk_ids = KFC_NR_CLK;
-	cmu.clk_regs = kfc_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(kfc_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &kfc_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_kfc, "samsung,exynos5260-clock-kfc",
@@ -1011,21 +1011,21 @@ static const struct samsung_gate_clock mfc_gate_clks[] __initconst = {
 			EN_IP_MFC_SECURE_SMMU2_MFC, 7, 0, 0),
 };
 
+static const struct samsung_cmu_info mfc_cmu __initconst = {
+	.mux_clks	= mfc_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(mfc_mux_clks),
+	.div_clks	= mfc_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(mfc_div_clks),
+	.gate_clks	= mfc_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(mfc_gate_clks),
+	.nr_clk_ids	= MFC_NR_CLK,
+	.clk_regs	= mfc_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(mfc_clk_regs),
+};
+
 static void __init exynos5260_clk_mfc_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.mux_clks = mfc_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(mfc_mux_clks);
-	cmu.div_clks = mfc_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(mfc_div_clks);
-	cmu.gate_clks = mfc_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(mfc_gate_clks);
-	cmu.nr_clk_ids = MFC_NR_CLK;
-	cmu.clk_regs = mfc_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(mfc_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &mfc_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_mfc, "samsung,exynos5260-clock-mfc",
@@ -1158,23 +1158,23 @@ static const struct samsung_pll_clock mif_pll_clks[] __initconst = {
 		pll2550_24mhz_tbl),
 };
 
+static const struct samsung_cmu_info mif_cmu __initconst = {
+	.pll_clks	= mif_pll_clks,
+	.nr_pll_clks	= ARRAY_SIZE(mif_pll_clks),
+	.mux_clks	= mif_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(mif_mux_clks),
+	.div_clks	= mif_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(mif_div_clks),
+	.gate_clks	= mif_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(mif_gate_clks),
+	.nr_clk_ids	= MIF_NR_CLK,
+	.clk_regs	= mif_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(mif_clk_regs),
+};
+
 static void __init exynos5260_clk_mif_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.pll_clks = mif_pll_clks;
-	cmu.nr_pll_clks =  ARRAY_SIZE(mif_pll_clks);
-	cmu.mux_clks = mif_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(mif_mux_clks);
-	cmu.div_clks = mif_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(mif_div_clks);
-	cmu.gate_clks = mif_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(mif_gate_clks);
-	cmu.nr_clk_ids = MIF_NR_CLK;
-	cmu.clk_regs = mif_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(mif_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &mif_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_mif, "samsung,exynos5260-clock-mif",
@@ -1366,21 +1366,21 @@ static const struct samsung_gate_clock peri_gate_clks[] __initconst = {
 		EN_IP_PERI_SECURE_TZPC, 20, 0, 0),
 };
 
+static const struct samsung_cmu_info peri_cmu __initconst = {
+	.mux_clks	= peri_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(peri_mux_clks),
+	.div_clks	= peri_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(peri_div_clks),
+	.gate_clks	= peri_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(peri_gate_clks),
+	.nr_clk_ids	= PERI_NR_CLK,
+	.clk_regs	= peri_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(peri_clk_regs),
+};
+
 static void __init exynos5260_clk_peri_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.mux_clks = peri_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(peri_mux_clks);
-	cmu.div_clks = peri_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(peri_div_clks);
-	cmu.gate_clks = peri_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(peri_gate_clks);
-	cmu.nr_clk_ids = PERI_NR_CLK;
-	cmu.clk_regs = peri_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(peri_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &peri_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_peri, "samsung,exynos5260-clock-peri",
@@ -1818,25 +1818,25 @@ static const struct samsung_pll_clock top_pll_clks[] __initconst = {
 		pll2650_24mhz_tbl),
 };
 
+static const struct samsung_cmu_info top_cmu __initconst = {
+	.pll_clks	= top_pll_clks,
+	.nr_pll_clks	= ARRAY_SIZE(top_pll_clks),
+	.mux_clks	= top_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(top_mux_clks),
+	.div_clks	= top_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(top_div_clks),
+	.gate_clks	= top_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(top_gate_clks),
+	.fixed_clks	= fixed_rate_clks,
+	.nr_fixed_clks	= ARRAY_SIZE(fixed_rate_clks),
+	.nr_clk_ids	= TOP_NR_CLK,
+	.clk_regs	= top_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(top_clk_regs),
+};
+
 static void __init exynos5260_clk_top_init(struct device_node *np)
 {
-	struct samsung_cmu_info cmu = { NULL };
-
-	cmu.pll_clks = top_pll_clks;
-	cmu.nr_pll_clks =  ARRAY_SIZE(top_pll_clks);
-	cmu.mux_clks = top_mux_clks;
-	cmu.nr_mux_clks = ARRAY_SIZE(top_mux_clks);
-	cmu.div_clks = top_div_clks;
-	cmu.nr_div_clks = ARRAY_SIZE(top_div_clks);
-	cmu.gate_clks = top_gate_clks;
-	cmu.nr_gate_clks = ARRAY_SIZE(top_gate_clks);
-	cmu.fixed_clks = fixed_rate_clks;
-	cmu.nr_fixed_clks = ARRAY_SIZE(fixed_rate_clks);
-	cmu.nr_clk_ids = TOP_NR_CLK;
-	cmu.clk_regs = top_clk_regs;
-	cmu.nr_clk_regs = ARRAY_SIZE(top_clk_regs);
-
-	samsung_cmu_register_one(np, &cmu);
+	samsung_cmu_register_one(np, &top_cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_top, "samsung,exynos5260-clock-top",
-- 
1.9.1
