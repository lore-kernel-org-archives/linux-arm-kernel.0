From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 7 Sep 2016 00:01:56 +0800
Subject: [PATCH v2 6/9] drm/panel: Add Netron DY E231732
In-Reply-To: <20160906144620.6322-7-maxime.ripard@free-electrons.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-7-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64RQdHZod7z4ErycNgGremj41-o4R_V_i7ThrCPLNhZOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 6, 2016 at 10:46 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The E231732 is a 7" panel with a resolution of 800x480.

>From what I could make out of an archived version of Netron's website
(it's unreachable from my place), they are a manufacturer of printed
ribbon cables, not LCD panels. This is probably a no-go.

On the side, my A23 tablet's LCD ribbon cable only had a model
name, which led me to multiple Aliexpress entries.

ChenYu

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 85143d1b9b31..85e988b51fbe 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1136,6 +1136,29 @@ static const struct panel_desc nec_nl4827hc19_05b = {
>         .bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
>  };
>
> +static const struct drm_display_mode netron_dy_e231732_mode = {
> +       .clock = 66000,
> +       .hdisplay = 1024,
> +       .hsync_start = 1024 + 160,
> +       .hsync_end = 1024 + 160 + 70,
> +       .htotal = 1024 + 160 + 70 + 90,
> +       .vdisplay = 600,
> +       .vsync_start = 600 + 127,
> +       .vsync_end = 600 + 127 + 20,
> +       .vtotal = 600 + 127 + 20 + 3,
> +       .vrefresh = 60,
> +};
> +
> +static const struct panel_desc netron_dy_e231732 = {
> +       .modes = &netron_dy_e231732_mode,
> +       .num_modes = 1,
> +       .size = {
> +               .width = 154,
> +               .height = 87,
> +       },
> +       .bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> +};
> +
>  static const struct display_timing okaya_rs800480t_7x0gp_timing = {
>         .pixelclock = { 30000000, 30000000, 40000000 },
>         .hactive = { 800, 800, 800 },
> @@ -1644,6 +1667,9 @@ static const struct of_device_id platform_of_match[] = {
>                 .compatible = "shelly,sca07010-bfn-lnn",
>                 .data = &shelly_sca07010_bfn_lnn,
>         }, {
> +               .compatible = "netron-dy,e231732",
> +               .data = &netron_dy_e231732,
> +       }, {
>                 .compatible = "starry,kr122ea0sra",
>                 .data = &starry_kr122ea0sra,
>         }, {
> --
> 2.9.3
>
