From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 24 Jan 2013 14:01:14 +0100
Subject: [PATCH 3/4] drm/tilcdc: add encoder slave
In-Reply-To: <1358894185-21617-4-git-send-email-robdclark@gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-4-git-send-email-robdclark@gmail.com>
Message-ID: <20130124130114.GB31306@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 04:36:24PM -0600, Rob Clark wrote:
> Add output panel driver for i2c encoder slaves.
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>

Found some more stuff ...

[cut]

> +static const struct drm_encoder_helper_funcs slave_encoder_helper_funcs = {
> +		.dpms           = drm_i2c_encoder_dpms,
> +		.mode_fixup     = drm_i2c_encoder_mode_fixup,
> +		.prepare        = slave_encoder_prepare,
> +		.commit         = drm_i2c_encoder_commit,
> +		.mode_set       = drm_i2c_encoder_mode_set,
> +		.save           = drm_i2c_encoder_save,
> +		.restore        = drm_i2c_encoder_restore,
> +};

I couldn't find these wrappers anywhere ...

> +
> +static const struct i2c_board_info info = {
> +		I2C_BOARD_INFO("tda998x", 0x70)
> +};

Shouldn't there be some of/devicetree thing to tell us which one to load?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
