From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 21 Jul 2016 14:07:53 -0400
Subject: [PATCH] GPU-DRM-Exynos: Delete an unnecessary check before the
 function call "vunmap"
In-Reply-To: <a5a79711-10a3-e304-a897-892ebdf2ff9f@users.sourceforge.net>
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
 <5317A59D.4@users.sourceforge.net> <54D28870.3060400@users.sourceforge.net>
 <54D329D0.7050006@samsung.com>
 <a5a79711-10a3-e304-a897-892ebdf2ff9f@users.sourceforge.net>
Message-ID: <CAOw6vb+PqxeU4ioJ0SxF2W_zEJBJHg8PdJYEyF1M0wxXNzU5_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 1:42 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 21 Jul 2016 19:23:25 +0200
>
> The vunmap() function performs also input parameter validation.
> Thus the test around the call is not needed.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to drm-misc

> ---
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> index dd09117..4cfb39d 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> @@ -269,8 +269,7 @@ static void exynos_drm_fbdev_destroy(struct drm_device *dev,
>         struct exynos_drm_gem *exynos_gem = exynos_fbd->exynos_gem;
>         struct drm_framebuffer *fb;
>
> -       if (exynos_gem->kvaddr)
> -               vunmap(exynos_gem->kvaddr);
> +       vunmap(exynos_gem->kvaddr);
>
>         /* release drm framebuffer and real buffer */
>         if (fb_helper->fb && fb_helper->fb->funcs) {
> --
> 2.9.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
