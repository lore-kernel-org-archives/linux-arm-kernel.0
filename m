From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Apr 2014 10:40:03 +0800
Subject: [PATCH] clk: sirf: fix a bundle of checkpatch issues
Message-ID: <1397529603-16937-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bin Shi <Bin.Shi@csr.com>

fix the below checkpatch issues about which users of codes - key customers care
very much.

WARNING: line over 80 characters
66: FILE: clk-atlas6.c:66:
+	usp2,   vip,   gfx,   gfx2d,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,

total: 0 errors, 1 warnings, 153 lines checked

clk-atlas6.c has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
WARNING: line over 80 characters
24: FILE: clk-common.c:24:
+ *     Each clock domain can select its own clock source from five clock sources,
WARNING: line over 80 characters
25: FILE: clk-common.c:25:
+ *     X_XIN, X_XINW, PLL1, PLL2 and PLL3. The domain clock is used as the source

WARNING: line over 80 characters
171: FILE: clk-common.c:171:
+	return pll_clk_round_rate(__clk_get_hw(parent_clk), rate, &pll_parent_rate);

WARNING: static const char * array should probably be static const char * const
191: FILE: clk-common.c:191:
+static const char *pll_clk_parents[] = {

WARNING: line over 80 characters
260: FILE: clk-common.c:260:
+static unsigned long usb_pll_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)

WARNING: static const char * array should probably be static const char * const
287: FILE: clk-common.c:287:
+static const char *dmn_clk_parents[] = {

WARNING: static const char * array should probably be static const char * const
676: FILE: clk-common.c:676:
+static const char *std_clk_io_parents[] = {

WARNING: static const char * array should probably be static const char * const
952: FILE: clk-common.c:952:
+static const char *std_clk_dsp_parents[] = {

WARNING: static const char * array should probably be static const char * const
984: FILE: clk-common.c:984:
+static const char *std_clk_sys_parents[] = {

WARNING: static const char * array should probably be static const char * const
1002: FILE: clk-common.c:1002:
+static const char *std_clk_usb_parents[] = {

total: 0 errors, 10 warnings, 1032 lines checked

clk-common.c has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
total: 0 errors, 0 warnings, 1032 lines checked

clk-common.c.orig has no obvious style problems and is ready for submission.
WARNING: line over 80 characters
65: FILE: clk-prima2.c:65:
+	usp2,   vip,   gfx,   mm,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,

total: 0 errors, 1 warnings, 152 lines checked

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clk/sirf/clk-atlas6.c |    8 ++++----
 drivers/clk/sirf/clk-common.c |   22 ++++++++++++----------
 drivers/clk/sirf/clk-prima2.c |   10 +++++-----
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/sirf/clk-atlas6.c b/drivers/clk/sirf/clk-atlas6.c
index d63b76c..b068feb 100644
--- a/drivers/clk/sirf/clk-atlas6.c
+++ b/drivers/clk/sirf/clk-atlas6.c
@@ -60,10 +60,10 @@ static struct clk_dmn clk_nand = {
 
 enum atlas6_clk_index {
 	/* 0    1     2      3      4      5      6       7         8      9 */
-	rtc,    osc,   pll1,  pll2,  pll3,  mem,   sys,   security, dsp,   gps,
-	mf,     io,    cpu,   uart0, uart1, uart2, tsc,   i2c0,     i2c1,  spi0,
-	spi1,   pwmc,  efuse, pulse, dmac0, dmac1, nand,  audio,    usp0,  usp1,
-	usp2,   vip,   gfx,   gfx2d,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
+	rtc,  osc,   pll1,  pll2,  pll3,  mem,   sys,   security, dsp,   gps,
+	mf,   io,    cpu,   uart0, uart1, uart2, tsc,   i2c0,     i2c1,  spi0,
+	spi1, pwmc,  efuse, pulse, dmac0, dmac1, nand,  audio,    usp0,  usp1,
+	usp2, vip,   gfx,   gfx2d, lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
 	usb0,  usb1,   cphif, maxclk,
 };
 
diff --git a/drivers/clk/sirf/clk-common.c b/drivers/clk/sirf/clk-common.c
index 37af51c..aebaec01 100644
--- a/drivers/clk/sirf/clk-common.c
+++ b/drivers/clk/sirf/clk-common.c
@@ -21,8 +21,8 @@ static struct clk_onecell_data clk_data;
  * - 2 exclusive plls: usb phy pll and sata phy pll
  * - 8 clock domains: cpu/cpudiv, mem/memdiv, sys/io, dsp, graphic, multimedia,
  *     display and sdphy.
- *     Each clock domain can select its own clock source from five clock sources,
- *     X_XIN, X_XINW, PLL1, PLL2 and PLL3. The domain clock is used as the source
+ *     Each clock domain can select its own clock source from 5 clock sources,
+ *     X_XIN, X_XINW, PLL1, PLL2 & PLL3. Domain clock is used as the source
  *     clock of the group clock.
  *     - dsp domain: gps, mf
  *     - io domain: dmac, nand, audio, uart, i2c, spi, usp, pwm, pulse
@@ -168,7 +168,8 @@ static long cpu_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk *parent_clk = clk_get_parent(hw->clk);
 	struct clk *pll_parent_clk = clk_get_parent(parent_clk);
 	unsigned long pll_parent_rate = clk_get_rate(pll_parent_clk);
-	return pll_clk_round_rate(__clk_get_hw(parent_clk), rate, &pll_parent_rate);
+	return pll_clk_round_rate(__clk_get_hw(parent_clk),
+		rate, &pll_parent_rate);
 }
 
 static unsigned long cpu_clk_recalc_rate(struct clk_hw *hw,
@@ -188,7 +189,7 @@ static struct clk_ops std_pll_ops = {
 	.set_rate = pll_clk_set_rate,
 };
 
-static const char *pll_clk_parents[] = {
+static const char * const pll_clk_parents[] = {
 	"osc",
 };
 
@@ -257,7 +258,8 @@ static void usb_pll_clk_disable(struct clk_hw *clk)
 	writel(reg, sirfsoc_rsc_vbase + SIRFSOC_USBPHY_PLL_CTRL);
 }
 
-static unsigned long usb_pll_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+static unsigned long usb_pll_clk_recalc_rate(struct clk_hw *hw,
+	unsigned long parent_rate)
 {
 	u32 reg = readl(sirfsoc_rsc_vbase + SIRFSOC_USBPHY_PLL_CTRL);
 	return (reg & SIRFSOC_USBPHY_PLL_BYPASS) ? parent_rate : 48*MHZ;
@@ -284,7 +286,7 @@ static struct clk_hw usb_pll_clk_hw = {
  * clock domains - cpu, mem, sys/io, dsp, gfx
  */
 
-static const char *dmn_clk_parents[] = {
+static const char * const dmn_clk_parents[] = {
 	"rtc",
 	"osc",
 	"pll1",
@@ -673,7 +675,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	clkc_writel(val, reg);
 }
 
-static const char *std_clk_io_parents[] = {
+static const char * const std_clk_io_parents[] = {
 	"io",
 };
 
@@ -949,7 +951,7 @@ static struct clk_std clk_pulse = {
 	},
 };
 
-static const char *std_clk_dsp_parents[] = {
+static const char * const std_clk_dsp_parents[] = {
 	"dsp",
 };
 
@@ -981,7 +983,7 @@ static struct clk_std clk_mf = {
 	},
 };
 
-static const char *std_clk_sys_parents[] = {
+static const char * const std_clk_sys_parents[] = {
 	"sys",
 };
 
@@ -999,7 +1001,7 @@ static struct clk_std clk_security = {
 	},
 };
 
-static const char *std_clk_usb_parents[] = {
+static const char * const std_clk_usb_parents[] = {
 	"usb_pll",
 };
 
diff --git a/drivers/clk/sirf/clk-prima2.c b/drivers/clk/sirf/clk-prima2.c
index 6968e2e..83d74c4 100644
--- a/drivers/clk/sirf/clk-prima2.c
+++ b/drivers/clk/sirf/clk-prima2.c
@@ -59,11 +59,11 @@ static struct clk_std clk_nand = {
 
 enum prima2_clk_index {
 	/* 0    1     2      3      4      5      6       7         8      9 */
-	rtc,    osc,   pll1,  pll2,  pll3,  mem,   sys,   security, dsp,   gps,
-	mf,     io,    cpu,   uart0, uart1, uart2, tsc,   i2c0,     i2c1,  spi0,
-	spi1,   pwmc,  efuse, pulse, dmac0, dmac1, nand,  audio,    usp0,  usp1,
-	usp2,   vip,   gfx,   mm,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
-	usb0,  usb1,   cphif, maxclk,
+	rtc,  osc,  pll1,  pll2,  pll3,  mem,   sys,   security, dsp,   gps,
+	mf,   io,   cpu,   uart0, uart1, uart2, tsc,   i2c0,     i2c1,  spi0,
+	spi1, pwmc, efuse, pulse, dmac0, dmac1, nand,  audio,    usp0,  usp1,
+	usp2, vip,  gfx,   mm,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
+	usb0, usb1, cphif, maxclk,
 };
 
 static __initdata struct clk_hw *prima2_clk_hw_array[maxclk] = {
-- 
1.7.5.4
