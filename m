From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 25 Jul 2016 10:43:32 +0200
Subject: [PATCH] GPU-DRM: Delete an unnecessary check before
 drm_property_unreference_blob()
In-Reply-To: <515bcb7e-3e00-3438-cc47-227cfcd41990@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <515bcb7e-3e00-3438-cc47-227cfcd41990@users.sourceforge.net>
Message-ID: <69fe77a4-d9fd-83b4-7821-f0a3c13d737f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/07/16 12:56, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 22 Jul 2016 12:48:12 +0200
>
> The drm_property_unreference_blob() function tests whether its argument
> is NULL and then returns immediately.
> Thus the test around the call is not needed.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 24aa3ba..07541d0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -112,9 +112,7 @@ static void mtk_drm_crtc_reset(struct drm_crtc *crtc)
>  	struct mtk_crtc_state *state;
>
>  	if (crtc->state) {
> -		if (crtc->state->mode_blob)
> -			drm_property_unreference_blob(crtc->state->mode_blob);
> -
> +		drm_property_unreference_blob(crtc->state->mode_blob);
>  		state = to_mtk_crtc_state(crtc->state);
>  		memset(state, 0, sizeof(*state));
>  	} else {
>
