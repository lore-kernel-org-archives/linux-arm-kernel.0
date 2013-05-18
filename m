From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 18 May 2013 19:46:44 +0200
Subject: [RFC 4/4] DRM: tda998x: add missing include
In-Reply-To: <1368897139-25485-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130518194644.2a02a4fc@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 May 2013 19:12:19 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> The RFC sent by Russell King was missing an include for tda998x. This
> is just a compatible clone to remember Russell to add that later.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: dri-devel at lists.freedesktop.org
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Jean-Francois Moine <moinejf@free.fr>
> ---
>  include/drm/i2c/tda998x.h |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 include/drm/i2c/tda998x.h
> 
> diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
> new file mode 100644
> index 0000000..41f799f
> --- /dev/null
> +++ b/include/drm/i2c/tda998x.h
> @@ -0,0 +1,23 @@
> +#ifndef __TDA998X_H__
> +#define __TDA998X_H__
> +
> +enum tda998x_audio_format {
> +	AFMT_I2S,
> +	AFMT_SPDIF,
> +};
> +
> +struct tda998x_encoder_params {
> +	int audio_cfg;
> +	int audio_clk_cfg;
> +	enum tda998x_audio_format audio_format;
> +	int audio_sample_rate;
> +	char audio_frame[6];
> +	int swap_a, mirr_a;
> +	int swap_b, mirr_b;
> +	int swap_c, mirr_c;
> +	int swap_d, mirr_d;
> +	int swap_e, mirr_e;
> +	int swap_f, mirr_f;
> +};
> +
> +#endif

These parameters should not be there. It seems to me that the DT is the
right place.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
