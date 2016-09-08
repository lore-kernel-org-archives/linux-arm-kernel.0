From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 14:56:01 +0200
Subject: [PATCH] drm/sun4i: add missing header dependencies
In-Reply-To: <1473332362-25497-1-git-send-email-baoyou.xie@linaro.org>
References: <1473332362-25497-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20160908125601.GQ8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 06:59:22PM +0800, Baoyou Xie wrote:
> We get 5 warnings when building kernel with W=1:
> drivers/gpu/drm/sun4i/sun4i_framebuffer.c:33:23: warning: no previous prototype for 'sun4i_framebuffer_init' [-Wmissing-prototypes]
> drivers/gpu/drm/sun4i/sun4i_framebuffer.c:47:6: warning: no previous prototype for 'sun4i_framebuffer_free' [-Wmissing-prototypes]
> drivers/gpu/drm/sun4i/sun4i_rgb.c:202:5: warning: no previous prototype for 'sun4i_rgb_init' [-Wmissing-prototypes]
> drivers/gpu/drm/sun4i/sun4i_dotclock.c:151:5: warning: no previous prototype for 'sun4i_dclk_create' [-Wmissing-prototypes]
> drivers/gpu/drm/sun4i/sun4i_dotclock.c:186:5: warning: no previous prototype for 'sun4i_dclk_free' [-Wmissing-prototypes]
> 
> In fact, these functions are declared in
> drivers/gpu/drm/sun4i/sun4i_framebuffer.h,
> drivers/gpu/drm/sun4i/sun4i_rgb.h,
> drivers/gpu/drm/sun4i/sun4i_dotclock.h,
> so this patch adds missing header dependencies.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/1db356f3/attachment.sig>
