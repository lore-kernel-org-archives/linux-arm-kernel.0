From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 20 Jul 2016 19:47:42 +0200
Subject: [PATCH] GPU-DRM-sun4i: Delete an unnecessary check before
 drm_fbdev_cma_hotplug_event()
In-Reply-To: <cd959d92-f7d9-598c-421f-d3f40bedee10@users.sourceforge.net>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <cd959d92-f7d9-598c-421f-d3f40bedee10@users.sourceforge.net>
Message-ID: <20160720174742.GA25486@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 06:40:49PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 20 Jul 2016 18:32:34 +0200
> 
> The drm_fbdev_cma_hotplug_event() function tests whether its argument
> is NULL and then returns immediately.
> Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to drm-misc, thanks.
-Daniel

> ---
>  drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> index a0b30c2..70688fe 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> @@ -20,8 +20,7 @@ static void sun4i_de_output_poll_changed(struct drm_device *drm)
>  {
>  	struct sun4i_drv *drv = drm->dev_private;
>  
> -	if (drv->fbdev)
> -		drm_fbdev_cma_hotplug_event(drv->fbdev);
> +	drm_fbdev_cma_hotplug_event(drv->fbdev);
>  }
>  
>  static const struct drm_mode_config_funcs sun4i_de_mode_config_funcs = {
> -- 
> 2.9.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
