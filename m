From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 13 Nov 2013 01:52:25 -0200
Subject: [PATCHv3 3/8] staging: imx-drm: ipuv3-crtc: don't harcode some
 mode flags.
In-Reply-To: <1384274965-30549-3-git-send-email-denis@eukrea.com>
References: <1384274965-30549-1-git-send-email-denis@eukrea.com>
 <1384274965-30549-3-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5ASDO22eHVLn18dQ31TJEjemtGp+SQqHk9XtYj6Hx3aLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Tue, Nov 12, 2013 at 2:49 PM, Denis Carikli <denis@eukrea.com> wrote:
> This change is needed for making the eukrea-cpuimx51
>   QVGA display work.
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: driverdev-devel at linuxdriverproject.org
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel at lists.freedesktop.org
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  drivers/staging/imx-drm/ipuv3-crtc.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> ChangeLog v2->v3:
> - Added some interested people in the Cc list.
> - Ajusted the flags to match the changes in "drm: Add the lacking
>   DRM_MODE_FLAG_* for matching the DISPLAY_FLAGS_*"
> ---
> diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
> index 670a56a..917818c 100644
> --- a/drivers/staging/imx-drm/ipuv3-crtc.c
> +++ b/drivers/staging/imx-drm/ipuv3-crtc.c
> @@ -155,9 +155,11 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
>                 sig_cfg.Hsync_pol = 1;
>         if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>                 sig_cfg.Vsync_pol = 1;
> +       if (mode->flags & DRM_MODE_FLAG_DE_HIGH)
> +               sig_cfg.enable_pol = 1;
> +       if (mode->flags & DRM_MODE_FLAG_PIXDATA_POSEDGE)
> +               sig_cfg.clk_pol = 1;
>
> -       sig_cfg.enable_pol = 1;
> -       sig_cfg.clk_pol = 1;


What are the sig_cfg.enable_pol and sig_cfg.clk_pol values you need
for your display to operate correctly?
