From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 May 2016 01:18:44 +0800
Subject: [PATCH 06/20] drm/sun4i: allow dclk to modify its parent rate
In-Reply-To: <1463402840-17062-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-7-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65tiUt9FvmJ2RaZdXaAFEznKZZjycO+tZcP-4spOAjObQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 16, 2016 at 8:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The pixel clock being only a divider of its parent clock, depending on the
> resolution, it's expected to change its parent rate. Add that flag so that
> the clock framework knows it.

This should be squashed into the previous patch. Otherwise, the previous one
doesn't really fix things, and probably makes things worse as it assumes the
parent clock would be changed.

ChenYu

> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_dotclock.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> index 1ddf6d7a7107..5b3463197c48 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> @@ -170,6 +170,7 @@ int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon)
>         init.ops = &sun4i_dclk_ops;
>         init.parent_names = &parent_name;
>         init.num_parents = 1;
> +       init.flags = CLK_SET_RATE_PARENT;
>
>         dclk->regmap = tcon->regs;
>         dclk->hw.init = &init;
> --
> 2.8.2
>
