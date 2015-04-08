From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Apr 2015 15:22:17 +0200
Subject: [PATCH 6/8] clk: sirf: Constify parent names in clock init data
In-Reply-To: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
References: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1428499339-29569-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The array of parent names can be made as array of const pointers to
const strings.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/sirf/clk-common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sirf/clk-common.c b/drivers/clk/sirf/clk-common.c
index 37af51c5f213..e9cf5730effe 100644
--- a/drivers/clk/sirf/clk-common.c
+++ b/drivers/clk/sirf/clk-common.c
@@ -188,7 +188,7 @@ static struct clk_ops std_pll_ops = {
 	.set_rate = pll_clk_set_rate,
 };
 
-static const char *pll_clk_parents[] = {
+static const char * const pll_clk_parents[] = {
 	"osc",
 };
 
@@ -284,7 +284,7 @@ static struct clk_hw usb_pll_clk_hw = {
  * clock domains - cpu, mem, sys/io, dsp, gfx
  */
 
-static const char *dmn_clk_parents[] = {
+static const char * const dmn_clk_parents[] = {
 	"rtc",
 	"osc",
 	"pll1",
@@ -673,7 +673,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	clkc_writel(val, reg);
 }
 
-static const char *std_clk_io_parents[] = {
+static const char * const std_clk_io_parents[] = {
 	"io",
 };
 
@@ -949,7 +949,7 @@ static struct clk_std clk_pulse = {
 	},
 };
 
-static const char *std_clk_dsp_parents[] = {
+static const char * const std_clk_dsp_parents[] = {
 	"dsp",
 };
 
@@ -981,7 +981,7 @@ static struct clk_std clk_mf = {
 	},
 };
 
-static const char *std_clk_sys_parents[] = {
+static const char * const std_clk_sys_parents[] = {
 	"sys",
 };
 
@@ -999,7 +999,7 @@ static struct clk_std clk_security = {
 	},
 };
 
-static const char *std_clk_usb_parents[] = {
+static const char * const std_clk_usb_parents[] = {
 	"usb_pll",
 };
 
-- 
1.9.1
