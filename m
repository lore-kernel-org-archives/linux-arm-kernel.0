From: patrik.r.jakobsson@gmail.com (Patrik Jakobsson)
Date: Mon, 15 Feb 2016 14:49:09 +0100
Subject: [PATCH v2 03/17] drm/exynos: removed optional dummy encoder
 mode_fixup function.
In-Reply-To: <3768b670931572de51fca1102efa18d20dd770ee.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
 <3768b670931572de51fca1102efa18d20dd770ee.1455540137.git.palminha@synopsys.com>
Message-ID: <CAMeQTsZLdMOnk7-isneoUyFBbQdiRUsGH6+EhD8W1LNB=80LVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlos

Any particular reason why this patch isn't squashed with patch 8/17?

Thanks
Patrik


On Mon, Feb 15, 2016 at 1:58 PM, Carlos Palminha
<CARLOS.PALMINHA@synopsys.com> wrote:
> mode_fixup function for encoder drivers became optional with patch
> http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha at synopsys.com
>
> This patch set nukes all the dummy mode_fixup implementations.
>
> (made on top of Daniel topic/drm-misc branch)
>
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index e977a81..736115c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1597,13 +1597,6 @@ static int exynos_dsi_create_connector(struct drm_encoder *encoder)
>         return 0;
>  }
>
> -static bool exynos_dsi_mode_fixup(struct drm_encoder *encoder,
> -                                 const struct drm_display_mode *mode,
> -                                 struct drm_display_mode *adjusted_mode)
> -{
> -       return true;
> -}
> -
>  static void exynos_dsi_mode_set(struct drm_encoder *encoder,
>                                 struct drm_display_mode *mode,
>                                 struct drm_display_mode *adjusted_mode)
> @@ -1623,7 +1616,6 @@ static void exynos_dsi_mode_set(struct drm_encoder *encoder,
>  }
>
>  static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
> -       .mode_fixup = exynos_dsi_mode_fixup,
>         .mode_set = exynos_dsi_mode_set,
>         .enable = exynos_dsi_enable,
>         .disable = exynos_dsi_disable,
> --
> 2.5.0
>
