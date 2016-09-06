From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Sep 2016 11:28:14 +0100
Subject: [PATCH] ASoC: sun4i-codec: Distinguish sun4i from sun7i
In-Reply-To: <20160905192404.13871-2-dannym@scratchpost.org>
References: <20160905192404.13871-1-dannym@scratchpost.org>
 <20160905192404.13871-2-dannym@scratchpost.org>
Message-ID: <20160906102814.GG3950@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 09:24:04PM +0200, Danny Milosavljevic wrote:

> -static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
> -	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
> -		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
> -		       sun4i_codec_pa_volume_scale),
> +#define SUN4I_COMMON_CODEC_CONTROLS \
> +	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,\
> +		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,\
> +		       sun4i_codec_pa_volume_scale)
> +
> +static const struct snd_kcontrol_new sun4i_codec_controls[] = {
> +	SUN4I_COMMON_CODEC_CONTROLS,
> +};

No, please don't do this - macros like this just make the code harder to
work with.  Do what everything else that handles multiple devices in one
driver does and have several different tables of controls, registering
the ones that are appropriate for the current device at runtime.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/5469bf65/attachment-0001.sig>
