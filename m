From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 18:09:22 +0000
Subject: [PATCH v3 5/5] ASoC: tda998x: adjust the audio CTS_N pre-divider
 from audio format
In-Reply-To: <df65a2de7d4afc2471846c02b73e8bbdc4f9a743.1391274628.git.moinejf@free.fr>
References: <cover.1391274627.git.moinejf@free.fr>
 <df65a2de7d4afc2471846c02b73e8bbdc4f9a743.1391274628.git.moinejf@free.fr>
Message-ID: <20140204180922.GN22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 12:08:06PM +0100, Jean-Francois Moine wrote:

> -	if (format == p->audio_format) {
> +	if (format == p->audio_format &&
> +	    params_format(params) == priv->audio_sample_format) {
>  		reg_write(priv, REG_ENA_AP, p->audio_cfg);
>  		return;

I find the above confusing and probably deserving of a comment
explaining the logic.  I think it's trying to skip noop configuration
updates?

>  	}
>  	p->audio_format = format;
> +	priv->audio_sample_format = params_format(params);

You should be using params_width() for the number of bits per sample.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/2983dfe7/attachment.sig>
