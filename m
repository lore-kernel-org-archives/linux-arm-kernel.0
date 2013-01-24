From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 24 Jan 2013 12:57:20 +0100
Subject: [PATCH 2/4] drm/i2c: nxp-tda998x (v2)
In-Reply-To: <1358894185-21617-3-git-send-email-robdclark@gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-3-git-send-email-robdclark@gmail.com>
Message-ID: <20130124115720.GV31870@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 04:36:23PM -0600, Rob Clark wrote:
> Driver for the NXP TDA998X i2c hdmi encoder slave.
> 
> v1: original
> v2: fix npix/nline programming
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>

Just one bikeshed, otherwise

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

[cut]

> +static void
> +reg_set(struct drm_encoder *encoder, uint16_t reg, uint8_t val)
> +{
> +	reg_write(encoder, reg, reg_read(encoder, reg) | val);
> +}
> +
> +static void
> +reg_clear(struct drm_encoder *encoder, uint16_t reg, uint8_t val)
> +{
> +	reg_write(encoder, reg, reg_read(encoder, reg) & ~val);
> +}

What about drivers/base/regmap? I haven't looked to closely yet and never
used it in code, but there's a presentation [1] and it sounds like it
provides some nice (and more important standardized) helper stuff for
debug, tracing, ...

Since encoder slave drivers tend to be utterly boring register bashing and
we expect tons of time, I think high levels of standardization would be
really useful. Care to look into this a bit?

Cheers, Daniel

1: http://free-electrons.com/blog/fosdem2012-videos/
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
