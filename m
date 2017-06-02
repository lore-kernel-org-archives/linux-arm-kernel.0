From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  2 Jun 2017 16:12:09 -0700
Subject: [PATCH 1/2] ARM: davinci: pdata-quirks: fix const warnings
In-Reply-To: <20170602231210.19553-1-khilman@baylibre.com>
References: <20170602231210.19553-1-khilman@baylibre.com>
Message-ID: <20170602231210.19553-2-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After VPIF was converted to enable getting subdevs from DT, the
pdata is no longer const, so remove these to avoid compiler warnings.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/pdata-quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
