From: sivaramn@nvidia.com (Sivaram Nair)
Date: Tue, 27 Nov 2012 08:53:33 +0200
Subject: [PATCH 1/1] ARM: tegra: replace long if statement group
Message-ID: <1353999213-4889-1-git-send-email-sivaramn@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The long list of if statements are replaced with corresponding
switch cases.

Signed-off-by: Sivaram Nair <sivaramn@nvidia.com>
---
 arch/arm/mach-tegra/tegra30_clocks.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra30_clocks.c b/arch/arm/mach-tegra/tegra30_clocks.c
index d714777..753addd 100644
--- a/arch/arm/mach-tegra/tegra30_clocks.c
+++ b/arch/arm/mach-tegra/tegra30_clocks.c
@@ -444,21 +444,23 @@ static unsigned long clk_measure_input_freq(void)
 	clk_writel(OSC_FREQ_DET_TRIG | 1, OSC_FREQ_DET);
 	do {} while (clk_readl(OSC_FREQ_DET_STATUS) & OSC_FREQ_DET_BUSY);
 	clock_autodetect = clk_readl(OSC_FREQ_DET_STATUS);
-	if (clock_autodetect >= 732 - 3 && clock_autodetect <= 732 + 3) {
+
+	switch (clock_autodetect) {
+	case (732 - 3)...(732 + 3):
 		return 12000000;
-	} else if (clock_autodetect >= 794 - 3 && clock_autodetect <= 794 + 3) {
+	case (794 - 3)...(794 + 3):
 		return 13000000;
-	} else if (clock_autodetect >= 1172 - 3 && clock_autodetect <= 1172 + 3) {
+	case (1172 - 3)...(1172 + 3):
 		return 19200000;
-	} else if (clock_autodetect >= 1587 - 3 && clock_autodetect <= 1587 + 3) {
+	case (1587 - 3)...(1587 + 3):
 		return 26000000;
-	} else if (clock_autodetect >= 1025 - 3 && clock_autodetect <= 1025 + 3) {
+	case (1025 - 3)...(1025 + 3):
 		return 16800000;
-	} else if (clock_autodetect >= 2344 - 3 && clock_autodetect <= 2344 + 3) {
+	case (2344 - 3)...(2344 + 3):
 		return 38400000;
-	} else if (clock_autodetect >= 2928 - 3 && clock_autodetect <= 2928 + 3) {
+	case (2928 - 3)...(2928 + 3):
 		return 48000000;
-	} else {
+	default:
 		pr_err("%s: Unexpected clock autodetect value %d", __func__,
 			clock_autodetect);
 		BUG();
-- 
1.7.9.5
