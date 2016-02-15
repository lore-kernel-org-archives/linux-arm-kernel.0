From: patrik.r.jakobsson@gmail.com (Patrik Jakobsson)
Date: Mon, 15 Feb 2016 15:24:01 +0100
Subject: [PATCH v2 09/17] drm/gma500: removed optional dummy encoder
 mode_fixup function.
In-Reply-To: <b704458dc68a73cfb5507933c1df0c2a79e186eb.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
 <b704458dc68a73cfb5507933c1df0c2a79e186eb.1455540137.git.palminha@synopsys.com>
Message-ID: <CAMeQTsZ=JP36ry8u_WAWgjz4sa4SPSpQmq3n+dACq0JhHonVSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 2:00 PM, Carlos Palminha
<CARLOS.PALMINHA@synopsys.com> wrote:
> mode_fixup function for encoder drivers became optional with patch
> http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha at synopsys.com
>
> This patch set nukes all the dummy mode_fixup implementations.
>
> (made on top of Daniel topic/drm-misc branch)
>
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>

Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

> ---
>  drivers/gpu/drm/gma500/cdv_intel_crt.c  | 1 -
>  drivers/gpu/drm/gma500/cdv_intel_hdmi.c | 1 -
>  drivers/gpu/drm/gma500/gma_display.c    | 7 -------
>  drivers/gpu/drm/gma500/gma_display.h    | 3 ---
>  drivers/gpu/drm/gma500/oaktrail_hdmi.c  | 1 -
>  5 files changed, 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_crt.c b/drivers/gpu/drm/gma500/cdv_intel_crt.c
> index d0717a8..b837e7a 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_crt.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_crt.c
> @@ -217,7 +217,6 @@ static int cdv_intel_crt_set_property(struct drm_connector *connector,
>
>  static const struct drm_encoder_helper_funcs cdv_intel_crt_helper_funcs = {
>         .dpms = cdv_intel_crt_dpms,
> -       .mode_fixup = gma_encoder_mode_fixup,
>         .prepare = gma_encoder_prepare,
>         .commit = gma_encoder_commit,
>         .mode_set = cdv_intel_crt_mode_set,
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
> index ddf2d77..28f9d90 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
> @@ -255,7 +255,6 @@ static void cdv_hdmi_destroy(struct drm_connector *connector)
>
>  static const struct drm_encoder_helper_funcs cdv_hdmi_helper_funcs = {
>         .dpms = cdv_hdmi_dpms,
> -       .mode_fixup = gma_encoder_mode_fixup,
>         .prepare = gma_encoder_prepare,
>         .mode_set = cdv_hdmi_mode_set,
>         .commit = gma_encoder_commit,
> diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
> index ff17af4..9270821 100644
> --- a/drivers/gpu/drm/gma500/gma_display.c
> +++ b/drivers/gpu/drm/gma500/gma_display.c
> @@ -478,13 +478,6 @@ int gma_crtc_cursor_move(struct drm_crtc *crtc, int x, int y)
>         return 0;
>  }
>
> -bool gma_encoder_mode_fixup(struct drm_encoder *encoder,
> -                           const struct drm_display_mode *mode,
> -                           struct drm_display_mode *adjusted_mode)
> -{
> -       return true;
> -}
> -
>  bool gma_crtc_mode_fixup(struct drm_crtc *crtc,
>                          const struct drm_display_mode *mode,
>                          struct drm_display_mode *adjusted_mode)
> diff --git a/drivers/gpu/drm/gma500/gma_display.h b/drivers/gpu/drm/gma500/gma_display.h
> index ed569d8..78b9f98 100644
> --- a/drivers/gpu/drm/gma500/gma_display.h
> +++ b/drivers/gpu/drm/gma500/gma_display.h
> @@ -90,9 +90,6 @@ extern void gma_crtc_restore(struct drm_crtc *crtc);
>  extern void gma_encoder_prepare(struct drm_encoder *encoder);
>  extern void gma_encoder_commit(struct drm_encoder *encoder);
>  extern void gma_encoder_destroy(struct drm_encoder *encoder);
> -extern bool gma_encoder_mode_fixup(struct drm_encoder *encoder,
> -                                  const struct drm_display_mode *mode,
> -                                  struct drm_display_mode *adjusted_mode);
>
>  /* Common clock related functions */
>  extern const struct gma_limit_t *gma_limit(struct drm_crtc *crtc, int refclk);
> diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> index 2d18499..8b2eb32 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> @@ -601,7 +601,6 @@ static void oaktrail_hdmi_destroy(struct drm_connector *connector)
>
>  static const struct drm_encoder_helper_funcs oaktrail_hdmi_helper_funcs = {
>         .dpms = oaktrail_hdmi_dpms,
> -       .mode_fixup = gma_encoder_mode_fixup,
>         .prepare = gma_encoder_prepare,
>         .mode_set = oaktrail_hdmi_mode_set,
>         .commit = gma_encoder_commit,
> --
> 2.5.0
>
