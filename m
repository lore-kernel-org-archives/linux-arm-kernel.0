From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 05 Sep 2016 01:03:03 +0800
Subject: [PATCH 4/7] drm/panel: Add Sinlinx SinA33 7" panel
In-Reply-To: <20160901153204.11217-5-maxime.ripard@free-electrons.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-5-maxime.ripard@free-electrons.com>
Message-ID: <66681473008583@web28j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Everyone,

01.09.2016, 23:40, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> ?The SinA33 has an unidentified panel. Add the timings for it under a new
> ?compatible.



Excuse me...
I will ask a question which is not fully related to the patch here...
If I want to add a generic panel for Q8 tablets, what should it be called?
"allwinner,q8-lcd-panel-800x480"?

And, Hans, do you have any examples for a 1024x600 Q8 A33 tablet?
(If the answer is yes, I think sun8i-a33-q8-tablet.dts will met a split...)

Thanks,
Icenowy

> ?Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ?---
> ??drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
> ??1 file changed, 26 insertions(+)
>
> ?diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> ?index 85143d1b9b31..af142e804245 100644
> ?--- a/drivers/gpu/drm/panel/panel-simple.c
> ?+++ b/drivers/gpu/drm/panel/panel-simple.c
> ?@@ -1409,6 +1409,29 @@ static const struct panel_desc shelly_sca07010_bfn_lnn = {
> ??????????.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> ??};
>
> ?+static const struct drm_display_mode sinlinx_sina33_lcd_7_mode = {
> ?+ .clock = 66000,
> ?+ .hdisplay = 1024,
> ?+ .hsync_start = 1024 + 160,
> ?+ .hsync_end = 1024 + 160 + 70,
> ?+ .htotal = 1024 + 160 + 70 + 90,
> ?+ .vdisplay = 600,
> ?+ .vsync_start = 600 + 127,
> ?+ .vsync_end = 600 + 127 + 20,
> ?+ .vtotal = 600 + 127 + 20 + 3,
> ?+ .vrefresh = 60,
> ?+};
> ?+
> ?+static const struct panel_desc sinlinx_sina33_lcd_7 = {
> ?+ .modes = &sinlinx_sina33_lcd_7_mode,
> ?+ .num_modes = 1,
> ?+ .size = {
> ?+ .width = 154,
> ?+ .height = 87,
> ?+ },
> ?+ .bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> ?+};
> ?+
> ??static const struct drm_display_mode starry_kr122ea0sra_mode = {
> ??????????.clock = 147000,
> ??????????.hdisplay = 1920,
> ?@@ -1644,6 +1667,9 @@ static const struct of_device_id platform_of_match[] = {
> ??????????????????.compatible = "shelly,sca07010-bfn-lnn",
> ??????????????????.data = &shelly_sca07010_bfn_lnn,
> ??????????}, {
> ?+ .compatible = "sinlinx,sina33-lcd-7",
> ?+ .data = &sinlinx_sina33_lcd_7,
> ?+ }, {
> ??????????????????.compatible = "starry,kr122ea0sra",
> ??????????????????.data = &starry_kr122ea0sra,
> ??????????}, {
> ?--
> ?2.9.2
>
> ?_______________________________________________
> ?linux-arm-kernel mailing list
> ?linux-arm-kernel at lists.infradead.org
> ?http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
