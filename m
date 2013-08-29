From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 29 Aug 2013 11:07:09 +0530
Subject: [PATCH v4 5/5] clk/exynos5420: assign dout_pixel id to pixel clock
 divider
In-Reply-To: <1377754629-31465-1-git-send-email-rahul.sharma@samsung.com>
References: <1377754629-31465-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1377754629-31465-6-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dout_pixel is a new ID allocated for pixel clock divider. It is
queried in the driver to pass as the parent to hdmi clock while
switching between parents.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 Documentation/devicetree/bindings/clock/exynos5420-clock.txt |    5 +++++
 drivers/clk/samsung/clk-exynos5420.c                         |    5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
index 343430b..32aa34e 100644
--- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
@@ -187,6 +187,11 @@ clock which they consume.
 
   mout_hdmi		640
 
+  Divider		ID
+  ----------------------------
+
+  dout_pixel		768
+
 Example 1: An example of a clock controller node is listed below.
 
 	clock: clock-controller at 0x10010000 {
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 78465a5..48c4a93 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -143,6 +143,9 @@ enum exynos5420_clks {
 	/* mux clocks */
 	mout_hdmi = 640,
 
+	/* divider clocks */
+	dout_pixel = 768,
+
 	nr_clks,
 };
 
@@ -463,7 +466,7 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(none, "dout_fimd1", "mout_fimd1", DIV_DISP10, 0, 4),
 	DIV(none, "dout_mipi1", "mout_mipi1", DIV_DISP10, 16, 8),
 	DIV(none, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
-	DIV(none, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
+	DIV(dout_pixel, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
 
 	/* Audio Block */
 	DIV(none, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
-- 
1.7.10.4
