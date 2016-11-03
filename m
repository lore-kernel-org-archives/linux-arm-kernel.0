From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Nov 2016 18:36:02 +0100
Subject: [PATCH v2 06/14] ASoC: sun4i-codec: Add support for A31 playback
 through headphone output
In-Reply-To: <20161103075556.29018-7-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-7-wens@csie.org>
Message-ID: <20161103173602.zchyciwj66zdibc7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 03, 2016 at 03:55:48PM +0800, Chen-Yu Tsai wrote:
> +/* headphone controls */
> +static const char * const sun6i_codec_hp_src_enum_text[] = {
> +	"DAC", "Mixer",
> +};
> +
> +static SOC_ENUM_DOUBLE_DECL(sun6i_codec_hp_src_enum,
> +			    SUN6I_CODEC_OM_DACA_CTRL,
> +			    SUN6I_CODEC_OM_DACA_CTRL_LHPIS,
> +			    SUN6I_CODEC_OM_DACA_CTRL_RHPIS,
> +			    sun6i_codec_hp_src_enum_text);
> +
> +static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
> +	SOC_DAPM_ENUM("Headphone Source Playback Route",
> +		      sun6i_codec_hp_src_enum),
> +};

What is that route exactly? A muxer?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/7eabc1f5/attachment.sig>
