From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 22 Dec 2011 19:31:45 +0200
Subject: [PATCH 4/5] OMAP: mcbsp: Remove old CLKR/FSR mux functions
In-Reply-To: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
References: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1324575106-17172-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New, single function has replaced the old mux configuration API for
CLKR/FSR configuration.
Remove the unused code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 -
 arch/arm/plat-omap/mcbsp.c              |   36 -------------------------------
 2 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 7f9a745..89aa33b 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -377,8 +377,6 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx);
 extern int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id);
 
 /* McBSP signal muxing API */
-void omap2_mcbsp1_mux_clkr_src(u8 mux);
-void omap2_mcbsp1_mux_fsr_src(u8 mux);
 int omap_mcbsp_6pin_src_mux(unsigned int id, u8 mux);
 
 int omap_mcbsp_dma_ch_params(unsigned int id, unsigned int stream);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 501c6d1..c48d974 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -921,42 +921,6 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 }
 EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
 
-void omap2_mcbsp1_mux_clkr_src(u8 mux)
-{
-	struct omap_mcbsp *mcbsp;
-	const char *src;
-
-	if (mux == CLKR_SRC_CLKR)
-		src = "clkr";
-	else if (mux == CLKR_SRC_CLKX)
-		src = "clkx";
-	else
-		return;
-
-	mcbsp = id_to_mcbsp_ptr(0);
-	if (mcbsp->pdata->mux_signal)
-		mcbsp->pdata->mux_signal(mcbsp->dev, "clkr", src);
-}
-EXPORT_SYMBOL(omap2_mcbsp1_mux_clkr_src);
-
-void omap2_mcbsp1_mux_fsr_src(u8 mux)
-{
-	struct omap_mcbsp *mcbsp;
-	const char *src;
-
-	if (mux == FSR_SRC_FSR)
-		src = "fsr";
-	else if (mux == FSR_SRC_FSX)
-		src = "fsx";
-	else
-		return;
-
-	mcbsp = id_to_mcbsp_ptr(0);
-	if (mcbsp->pdata->mux_signal)
-		mcbsp->pdata->mux_signal(mcbsp->dev, "fsr", src);
-}
-EXPORT_SYMBOL(omap2_mcbsp1_mux_fsr_src);
-
 int omap_mcbsp_6pin_src_mux(unsigned int id, u8 mux)
 {
 	struct omap_mcbsp *mcbsp;
-- 
1.7.8.1
