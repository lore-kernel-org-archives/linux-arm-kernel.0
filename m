From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 22 Sep 2018 21:23:55 +0800
Subject: [PATCH 13/27] drm/sun4i: Add support for H6 DE3 mixer 0
In-Reply-To: <20180902072643.4917-14-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-14-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66kp4B5VZfmTc8L6qt=OPHjbYBtXRbC=L6jGTzvEKvb=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Mixer 0 has 1 VI and 3 UI planes, scaler on all planes and can output
> 4K image @60Hz. It also support 10 bit colors.

AFAICT 10 bit color support is not implemented? Please mention this.

>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index a9218abf0935..54eca2dd4b33 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -540,6 +540,15 @@ static int sun8i_mixer_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {

Please sort the per-compatible structures according to "version sort" rules.

> +       .ccsc           = 0,
> +       .is_de3         = true,
> +       .mod_rate       = 600000000,
> +       .scaler_mask    = 0xf,
> +       .ui_num         = 3,
> +       .vi_num         = 1,
> +};
> +
>  static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
>         .ccsc           = 0,
>         .scaler_mask    = 0xf,
> @@ -587,6 +596,10 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
>  };
>
>  static const struct of_device_id sun8i_mixer_of_table[] = {
> +       {
> +               .compatible = "allwinner,sun50i-h6-de3-mixer-0",
> +               .data = &sun50i_h6_mixer0_cfg,
> +       },

Same here.

ChenYu

>         {
>                 .compatible = "allwinner,sun8i-a83t-de2-mixer-0",
>                 .data = &sun8i_a83t_mixer0_cfg,
> --
> 2.18.0
>
