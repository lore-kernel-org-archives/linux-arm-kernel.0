From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri,  5 Jul 2013 14:12:27 +0530
Subject: [PATCH 1/3] clk: exynos5250: Add G2D gate clock
Message-ID: <1373013749-14530-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds gate clock for G2D IP for Exynos5250 SoC.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>
---
This patch depends on the following patch:
http://thread.gmane.org/gmane.linux.kernel.samsung-soc/20581
---
 .../devicetree/bindings/clock/exynos5250-clock.txt |    1 +
 drivers/clk/samsung/clk-exynos5250.c               |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
index 1a05761..7e88242 100644
--- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
@@ -155,6 +155,7 @@ clock which they consume.
   dp			342
   mixer			343
   hdmi			344
+  g2d			345
 
 Example 1: An example of a clock controller node is listed below.
 
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 6f767c5..3da0bdf 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -62,6 +62,7 @@
 #define SRC_CDREX		0x20200
 #define PLL_DIV2_SEL		0x20a24
 #define GATE_IP_DISP1		0x10928
+#define GATE_IP_ACP		0x10000
 
 /*
  * Let each supported clock get a unique id. This id is used to lookup the clock
@@ -99,7 +100,7 @@ enum exynos5250_clks {
 	spi2, i2s1, i2s2, pcm1, pcm2, pwm, spdif, ac97, hsi2c0, hsi2c1, hsi2c2,
 	hsi2c3, chipid, sysreg, pmu, cmu_top, cmu_core, cmu_mem, tzpc0, tzpc1,
 	tzpc2, tzpc3, tzpc4, tzpc5, tzpc6, tzpc7, tzpc8, tzpc9, hdmi_cec, mct,
-	wdt, rtc, tmu, fimd1, mie1, dsim0, dp, mixer, hdmi,
+	wdt, rtc, tmu, fimd1, mie1, dsim0, dp, mixer, hdmi, g2d,
 
 	nr_clks,
 };
@@ -152,6 +153,7 @@ static __initdata unsigned long exynos5250_clk_regs[] = {
 	SRC_CDREX,
 	PLL_DIV2_SEL,
 	GATE_IP_DISP1,
+	GATE_IP_ACP,
 };
 
 /* list of all parent clock list */
@@ -463,6 +465,7 @@ struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(dp, "dp", "aclk200", GATE_IP_DISP1, 4, 0, 0),
 	GATE(mixer, "mixer", "aclk200", GATE_IP_DISP1, 5, 0, 0),
 	GATE(hdmi, "hdmi", "aclk200", GATE_IP_DISP1, 6, 0, 0),
+	GATE(g2d, "g2d", "aclk200", GATE_IP_ACP, 3, 0, 0),
 };
 
 static __initdata struct of_device_id ext_clk_match[] = {
-- 
1.7.9.5
