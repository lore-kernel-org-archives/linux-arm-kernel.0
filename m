From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 26 Aug 2009 15:36:05 +0100
Subject: [PATCH] SMDK6410: Add platform data for WM835x audio
Message-ID: <1251297365-21048-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not optimised, just some sensible default starting points.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index ea51dbe..7068754 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -316,6 +316,26 @@ static struct {
 	{ WM8350_LDO_4, &wm8350_ldo4_data },
 };
 
+static struct wm8350_audio_platform_data wm8350_audio = {
+	.vmid_discharge_msecs = 1000,
+	.drain_msecs = 30,
+	.cap_discharge_msecs = 700,
+	.vmid_charge_msecs = 700,
+	.vmid_s_curve = WM8350_S_CURVE_SLOW,
+	.dis_out4 = WM8350_DISCHARGE_SLOW,
+	.dis_out3 = WM8350_DISCHARGE_SLOW,
+	.dis_out2 = WM8350_DISCHARGE_SLOW,
+	.dis_out1 = WM8350_DISCHARGE_SLOW,
+	.vroi_out4 = WM8350_TIE_OFF_500R,
+	.vroi_out3 = WM8350_TIE_OFF_500R,
+	.vroi_out2 = WM8350_TIE_OFF_500R,
+	.vroi_out1 = WM8350_TIE_OFF_500R,
+	.vroi_enable = 0,
+	.codec_current_on = WM8350_CODEC_ISEL_1_0,
+	.codec_current_standby = WM8350_CODEC_ISEL_0_5,
+	.codec_current_charge = WM8350_CODEC_ISEL_1_5,
+};
+
 static int __init smdk6410_wm8350_init(struct wm8350 *wm8350)
 {
 	int i;
@@ -326,6 +346,8 @@ static int __init smdk6410_wm8350_init(struct wm8350 *wm8350)
 					  wm1190_regulators[i].regulator,
 					  wm1190_regulators[i].initdata);
 
+	wm8350->codec.platform_data = &wm8350_audio;
+
 	return 0;
 }
 
-- 
1.6.3.3
