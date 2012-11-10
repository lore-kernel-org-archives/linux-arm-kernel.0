From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 10 Nov 2012 12:13:45 +0530
Subject: [PATCH 6/8] CLK: SPEAr: Update clock rate table
In-Reply-To: <cover.1352529508.git.viresh.kumar@linaro.org>
References: <cover.1352529508.git.viresh.kumar@linaro.org>
Message-ID: <34c4b9a75f7ba96ad1f99de1409a4aaa1dc6afb9.1352529508.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Deepak Sikri <deepak.sikri@st.com>

This patch updates the existing rate tables with new frequencies.

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear1310_clock.c | 14 ++++++
 drivers/clk/spear/spear1340_clock.c | 89 ++++++++++++++++++++++++++++---------
 drivers/clk/spear/spear3xx_clock.c  |  6 +++
 drivers/clk/spear/spear6xx_clock.c  |  1 +
 4 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index b64d511..bc7f37e 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -313,6 +313,20 @@ static struct aux_clk_masks i2s_sclk_masks = {
 /* i2s prs1 aux rate configuration table, in ascending order of rates */
 static struct aux_rate_tbl i2s_prs1_rtbl[] = {
 	/* For parent clk = 49.152 MHz */
+	{.xscale = 1, .yscale = 12, .eq = 0}, /* 2.048 MHz, smp freq = 8Khz */
+	{.xscale = 11, .yscale = 96, .eq = 0}, /* 2.816 MHz, smp freq = 11Khz */
+	{.xscale = 1, .yscale = 6, .eq = 0}, /* 4.096 MHz, smp freq = 16Khz */
+	{.xscale = 11, .yscale = 48, .eq = 0}, /* 5.632 MHz, smp freq = 22Khz */
+
+	/*
+	 * with parent clk = 49.152, freq gen is 8.192 MHz, smp freq = 32Khz
+	 * with parent clk = 12.288, freq gen is 2.048 MHz, smp freq = 8Khz
+	 */
+	{.xscale = 1, .yscale = 3, .eq = 0},
+
+	/* For parent clk = 49.152 MHz */
+	{.xscale = 17, .yscale = 37, .eq = 0}, /* 11.289 MHz, smp freq = 44Khz*/
+
 	{.xscale = 1, .yscale = 2, .eq = 0}, /* 12.288 MHz */
 };
 
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 8f00533..d4de680 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -190,6 +190,7 @@ static struct pll_rate_tbl pll4_rtbl[] = {
  * different values of vco1div2
  */
 static struct frac_rate_tbl amba_synth_rtbl[] = {
+	{.div = 0x073A8}, /* for vco1div2 = 600 MHz */
 	{.div = 0x06062}, /* for vco1div2 = 500 MHz */
 	{.div = 0x04D1B}, /* for vco1div2 = 400 MHz */
 	{.div = 0x04000}, /* for vco1div2 = 332 MHz */
@@ -220,6 +221,12 @@ static struct frac_rate_tbl amba_synth_rtbl[] = {
  * 500			400		200			0x02800
  * 500			500		250			0x02000
  * --------------------------------------------------------------------
+ * 600			200		100			0x06000
+ * 600			250		125			0x04CCE
+ * 600			332		166			0x039D5
+ * 600			400		200			0x03000
+ * 600			500		250			0x02666
+ * --------------------------------------------------------------------
  * 664			200		100			0x06a38
  * 664			250		125			0x054FD
  * 664			332		166			0x04000
@@ -238,28 +245,50 @@ static struct frac_rate_tbl sys_synth_rtbl[] = {
 	{.div = 0x08000},
 	{.div = 0x06a38},
 	{.div = 0x06666},
+	{.div = 0x06000},
 	{.div = 0x054FD},
 	{.div = 0x05000},
 	{.div = 0x04D18},
+	{.div = 0x04CCE},
 	{.div = 0x04000},
+	{.div = 0x039D5},
 	{.div = 0x0351E},
 	{.div = 0x03333},
 	{.div = 0x03031},
+	{.div = 0x03000},
 	{.div = 0x02A7E},
 	{.div = 0x02800},
 	{.div = 0x0268D},
+	{.div = 0x02666},
 	{.div = 0x02000},
 };
 
 /* aux rate configuration table, in ascending order of rates */
 static struct aux_rate_tbl aux_rtbl[] = {
-	/* For VCO1div2 = 500 MHz */
-	{.xscale = 10, .yscale = 204, .eq = 0}, /* 12.29 MHz */
-	{.xscale = 4, .yscale = 21, .eq = 0}, /* 48 MHz */
-	{.xscale = 2, .yscale = 6, .eq = 0}, /* 83 MHz */
-	{.xscale = 2, .yscale = 4, .eq = 0}, /* 125 MHz */
-	{.xscale = 1, .yscale = 3, .eq = 1}, /* 166 MHz */
-	{.xscale = 1, .yscale = 2, .eq = 1}, /* 250 MHz */
+	/* 12.29MHz for vic1div2=600MHz and 10.24MHz for VCO1div2=500MHz */
+	{.xscale = 5, .yscale = 122, .eq = 0},
+	/* 14.70MHz for vic1div2=600MHz and 12.29MHz for VCO1div2=500MHz */
+	{.xscale = 10, .yscale = 204, .eq = 0},
+	/* 48MHz for vic1div2=600MHz and 40 MHz for VCO1div2=500MHz */
+	{.xscale = 4, .yscale = 25, .eq = 0},
+	/* 57.14MHz for vic1div2=600MHz and 48 MHz for VCO1div2=500MHz */
+	{.xscale = 4, .yscale = 21, .eq = 0},
+	/* 83.33MHz for vic1div2=600MHz and 69.44MHz for VCO1div2=500MHz */
+	{.xscale = 5, .yscale = 18, .eq = 0},
+	/* 100MHz for vic1div2=600MHz and 83.33 MHz for VCO1div2=500MHz */
+	{.xscale = 2, .yscale = 6, .eq = 0},
+	/* 125MHz for vic1div2=600MHz and 104.1MHz for VCO1div2=500MHz */
+	{.xscale = 5, .yscale = 12, .eq = 0},
+	/* 150MHz for vic1div2=600MHz and 125MHz for VCO1div2=500MHz */
+	{.xscale = 2, .yscale = 4, .eq = 0},
+	/* 166MHz for vic1div2=600MHz and 138.88MHz for VCO1div2=500MHz */
+	{.xscale = 5, .yscale = 18, .eq = 1},
+	/* 200MHz for vic1div2=600MHz and 166MHz for VCO1div2=500MHz */
+	{.xscale = 1, .yscale = 3, .eq = 1},
+	/* 250MHz for vic1div2=600MHz and 208.33MHz for VCO1div2=500MHz */
+	{.xscale = 5, .yscale = 12, .eq = 1},
+	/* 300MHz for vic1div2=600MHz and 250MHz for VCO1div2=500MHz */
+	{.xscale = 1, .yscale = 2, .eq = 1},
 };
 
 /* gmac rate configuration table, in ascending order of rates */
@@ -273,16 +302,23 @@ static struct aux_rate_tbl gmac_rtbl[] = {
 
 /* clcd rate configuration table, in ascending order of rates */
 static struct frac_rate_tbl clcd_rtbl[] = {
+	{.div = 0x18000}, /* 25 Mhz , for vc01div4 = 300 MHz*/
+	{.div = 0x1638E}, /* 27 Mhz , for vc01div4 = 300 MHz*/
 	{.div = 0x14000}, /* 25 Mhz , for vc01div4 = 250 MHz*/
 	{.div = 0x1284B}, /* 27 Mhz , for vc01div4 = 250 MHz*/
 	{.div = 0x0D8D3}, /* 58 Mhz , for vco1div4 = 393 MHz */
 	{.div = 0x0B72C}, /* 58 Mhz , for vco1div4 = 332 MHz */
+	{.div = 0x0A584}, /* 58 Mhz , for vco1div4 = 300 MHz */
+	{.div = 0x093B1}, /* 65 Mhz , for vc01div4 = 300 MHz*/
 	{.div = 0x089EE}, /* 58 Mhz , for vc01div4 = 250 MHz*/
+	{.div = 0x081BA}, /* 74 Mhz , for vc01div4 = 300 MHz*/
 	{.div = 0x07BA0}, /* 65 Mhz , for vc01div4 = 250 MHz*/
 	{.div = 0x06f1C}, /* 72 Mhz , for vc01div4 = 250 MHz*/
 	{.div = 0x06E58}, /* 58 Mhz , for vco1div4 = 200 MHz */
 	{.div = 0x06c1B}, /* 74 Mhz , for vc01div4 = 250 MHz*/
+	{.div = 0x058E3}, /* 108 Mhz , for vc01div4 = 300 MHz*/
 	{.div = 0x04A12}, /* 108 Mhz , for vc01div4 = 250 MHz*/
+	{.div = 0x040A5}, /* 148.5 Mhz , for vc01div4 = 300 MHz*/
 	{.div = 0x0378E}, /* 144 Mhz , for vc01div4 = 250 MHz*/
 	{.div = 0x0360D}, /* 148 Mhz , for vc01div4 = 250 MHz*/
 	{.div = 0x035E0}, /* 148.5 MHz, for vc01div4 = 250 MHz*/
@@ -351,20 +387,31 @@ static struct aux_rate_tbl adc_rtbl[] = {
 
 /* General synth rate configuration table, in ascending order of rates */
 static struct frac_rate_tbl gen_rtbl[] = {
-	/* For vco1div4 = 250 MHz */
-	{.div = 0x1624E}, /* 22.5792 MHz */
-	{.div = 0x14585}, /* 24.576 MHz */
-	{.div = 0x14000}, /* 25 MHz */
-	{.div = 0x0B127}, /* 45.1584 MHz */
-	{.div = 0x0A000}, /* 50 MHz */
-	{.div = 0x061A8}, /* 81.92 MHz */
-	{.div = 0x05000}, /* 100 MHz */
-	{.div = 0x02800}, /* 200 MHz */
-	{.div = 0x02620}, /* 210 MHz */
-	{.div = 0x02460}, /* 220 MHz */
-	{.div = 0x022C0}, /* 230 MHz */
-	{.div = 0x02160}, /* 240 MHz */
-	{.div = 0x02000}, /* 250 MHz */
+	{.div = 0x1A92B}, /* 22.5792 MHz for vco1div4=300 MHz*/
+	{.div = 0x186A0}, /* 24.576 MHz for vco1div4=300 MHz*/
+	{.div = 0x18000}, /* 25 MHz for vco1div4=300 MHz*/
+	{.div = 0x1624E}, /* 22.5792 MHz for vco1div4=250 MHz*/
+	{.div = 0x14585}, /* 24.576 MHz for vco1div4=250 MHz*/
+	{.div = 0x14000}, /* 25 MHz for vco1div4=250 MHz*/
+	{.div = 0x0D495}, /* 45.1584 MHz for vco1div4=300 MHz*/
+	{.div = 0x0C000}, /* 50 MHz for vco1div4=300 MHz*/
+	{.div = 0x0B127}, /* 45.1584 MHz for vco1div4=250 MHz*/
+	{.div = 0x0A000}, /* 50 MHz for vco1div4=250 MHz*/
+	{.div = 0x07530}, /* 81.92 MHz for vco1div4=300 MHz*/
+	{.div = 0x061A8}, /* 81.92 MHz for vco1div4=250 MHz*/
+	{.div = 0x06000}, /* 100 MHz for vco1div4=300 MHz*/
+	{.div = 0x05000}, /* 100 MHz for vco1div4=250 MHz*/
+	{.div = 0x03000}, /* 200 MHz for vco1div4=300 MHz*/
+	{.div = 0x02DB6}, /* 210 MHz for vco1div4=300 MHz*/
+	{.div = 0x02BA2}, /* 220 MHz for vco1div4=300 MHz*/
+	{.div = 0x029BD}, /* 230 MHz for vco1div4=300 MHz*/
+	{.div = 0x02800}, /* 200 MHz for vco1div4=250 MHz*/
+	{.div = 0x02666}, /* 250 MHz for vco1div4=300 MHz*/
+	{.div = 0x02620}, /* 210 MHz for vco1div4=250 MHz*/
+	{.div = 0x02460}, /* 220 MHz for vco1div4=250 MHz*/
+	{.div = 0x022C0}, /* 230 MHz for vco1div4=250 MHz*/
+	{.div = 0x02160}, /* 240 MHz for vco1div4=250 MHz*/
+	{.div = 0x02000}, /* 250 MHz for vco1div4=250 MHz*/
 };
 
 /* clock parents */
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index 1cc034b..ea6543e 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -107,6 +107,12 @@ static struct pll_rate_tbl pll_rtbl[] = {
 /* aux rate configuration table, in ascending order of rates */
 static struct aux_rate_tbl aux_rtbl[] = {
 	/* For PLL1 = 332 MHz */
+	{.xscale = 1, .yscale = 81, .eq = 0}, /* 2.049 MHz */
+	{.xscale = 1, .yscale = 59, .eq = 0}, /* 2.822 MHz */
+	{.xscale = 2, .yscale = 81, .eq = 0}, /* 4.098 MHz */
+	{.xscale = 3, .yscale = 89, .eq = 0}, /* 5.644 MHz */
+	{.xscale = 4, .yscale = 81, .eq = 0}, /* 8.197 MHz */
+	{.xscale = 4, .yscale = 59, .eq = 0}, /* 11.254 MHz */
 	{.xscale = 2, .yscale = 27, .eq = 0}, /* 12.296 MHz */
 	{.xscale = 2, .yscale = 8, .eq = 0}, /* 41.5 MHz */
 	{.xscale = 2, .yscale = 4, .eq = 0}, /* 83 MHz */
diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index e8d2b31..8a81770 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -92,6 +92,7 @@ static struct pll_rate_tbl pll_rtbl[] = {
 /* aux rate configuration table, in ascending order of rates */
 static struct aux_rate_tbl aux_rtbl[] = {
 	/* For PLL1 = 332 MHz */
+	{.xscale = 2, .yscale = 27, .eq = 0}, /* 12.296 MHz */
 	{.xscale = 2, .yscale = 8, .eq = 0}, /* 41.5 MHz */
 	{.xscale = 2, .yscale = 4, .eq = 0}, /* 83 MHz */
 	{.xscale = 1, .yscale = 2, .eq = 1}, /* 166 MHz */
-- 
1.7.12.rc2.18.g61b472e
