From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 24 Jul 2013 19:43:33 +0530
Subject: [PATCH v3 3/5] clk/exynos5250: add sclk_hdmiphy in the list of special
 clocks
In-Reply-To: <1374675215-27862-1-git-send-email-rahul.sharma@samsung.com>
References: <1374675215-27862-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1374675215-27862-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hdmi driver needs hdmiphy clock which is one of the parent
for hdmi mux clock. This is required while changing the parent
of mux clock.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>

Conflicts:
	drivers/clk/samsung/clk-exynos5250.c
---
 Documentation/devicetree/bindings/clock/exynos5250-clock.txt |    1 +
 drivers/clk/samsung/clk-exynos5250.c                         |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
index 488fbb2..10b9f2a 100644
--- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
@@ -61,6 +61,7 @@ clock which they consume.
   sclk_spi2		156
   div_i2s1		157
   div_i2s2		158
+  sclk_hdmiphy		159
 
 
    [Peripheral Clock Gates]
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index df44419..9579cfe 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -87,7 +87,7 @@ enum exynos5250_clks {
 	sclk_mmc0, sclk_mmc1, sclk_mmc2, sclk_mmc3, sclk_sata, sclk_usb3,
 	sclk_jpeg, sclk_uart0, sclk_uart1, sclk_uart2, sclk_uart3, sclk_pwm,
 	sclk_audio1, sclk_audio2, sclk_spdif, sclk_spi0, sclk_spi1, sclk_spi2,
-	div_i2s1, div_i2s2,
+	div_i2s1, div_i2s2, sclk_hdmiphy,
 
 	/* gate clocks */
 	gscl0 = 256, gscl1, gscl2, gscl3, gscl_wa, gscl_wb, smmu_gscl0,
@@ -200,7 +200,7 @@ struct samsung_fixed_rate_clock exynos5250_fixed_rate_ext_clks[] __initdata = {
 
 /* fixed rate clocks generated inside the soc */
 struct samsung_fixed_rate_clock exynos5250_fixed_rate_clks[] __initdata = {
-	FRATE(none, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 24000000),
+	FRATE(sclk_hdmiphy, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 24000000),
 	FRATE(none, "sclk_hdmi27m", NULL, CLK_IS_ROOT, 27000000),
 	FRATE(none, "sclk_dptxphy", NULL, CLK_IS_ROOT, 24000000),
 	FRATE(none, "sclk_uhostphy", NULL, CLK_IS_ROOT, 48000000),
-- 
1.7.10.4
