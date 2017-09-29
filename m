From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Sep 2017 12:19:18 +0200
Subject: [PATCH v3 03/14] drm/sun4i: tcon: Add variant callback for TCON
 output muxing
In-Reply-To: <20170929082306.16193-4-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
 <20170929082306.16193-4-wens@csie.org>
Message-ID: <20170929101918.h7lfefk3bjj2lf74@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 08:22:55AM +0000, Chen-Yu Tsai wrote:
>  static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
> -	.has_unknown_mux = true,
> -	.has_channel_1	= true,
> +	.has_unknown_mux	= true,
> +	.has_channel_1		= true,
> +	.set_mux		= sun5i_a13_tcon_set_mux,

I guess we could even retire has_unknown_mux now, since it provides
the same information than if set_mux is set or to NULL.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170929/35d6bc14/attachment-0001.sig>
