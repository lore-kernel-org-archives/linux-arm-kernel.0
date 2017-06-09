From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  9 Jun 2017 10:21:10 -0700
Subject: [PATCH v2 1/2] ARM: davinci: pdata-quirks: fix const warnings
In-Reply-To: <20170609172111.23057-1-khilman@baylibre.com>
References: <20170609172111.23057-1-khilman@baylibre.com>
Message-ID: <20170609172111.23057-2-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After VPIF was converted to enable getting subdevs from DT, the
pdata is no longer const, so remove these to avoid compiler warnings.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 4 ++--
 arch/arm/mach-davinci/pdata-quirks.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index cb176826d1cb..055e947a6a39 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -641,7 +641,7 @@ static struct vpif_subdev_info vpif_capture_sdev_info[] = {
 	},
 };
 
-static const struct vpif_input dm6467_ch0_inputs[] = {
+static struct vpif_input dm6467_ch0_inputs[] = {
 	{
 		.input = {
 			.index = 0,
@@ -656,7 +656,7 @@ static const struct vpif_input dm6467_ch0_inputs[] = {
 	},
 };
 
-static const struct vpif_input dm6467_ch1_inputs[] = {
+static struct vpif_input dm6467_ch1_inputs[] = {
        {
 		.input = {
 			.index = 0,
diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index 329f5402ad1d..4858b1cdf31b 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -33,7 +33,7 @@ static struct tvp514x_platform_data tvp5146_pdata = {
 
 #define TVP514X_STD_ALL (V4L2_STD_NTSC | V4L2_STD_PAL)
 
-static const struct vpif_input da850_ch0_inputs[] = {
+static struct vpif_input da850_ch0_inputs[] = {
 	{
 		.input = {
 			.index = 0,
@@ -48,7 +48,7 @@ static const struct vpif_input da850_ch0_inputs[] = {
 	},
 };
 
-static const struct vpif_input da850_ch1_inputs[] = {
+static struct vpif_input da850_ch1_inputs[] = {
 	{
 		.input = {
 			.index = 0,
-- 
2.9.3
