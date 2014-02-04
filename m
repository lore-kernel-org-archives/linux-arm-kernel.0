From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 18:06:25 +0000
Subject: [PATCH v3 4/5] ASoC: tda998x: adjust the audio hw parameters
 from EDID
In-Reply-To: <1b15025671d9099863a3091346536e45891e4a26.1391274628.git.moinejf@free.fr>
References: <cover.1391274627.git.moinejf@free.fr>
 <1b15025671d9099863a3091346536e45891e4a26.1391274628.git.moinejf@free.fr>
Message-ID: <20140204180625.GM22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 09:48:54AM +0100, Jean-Francois Moine wrote:

> +		/* change the snd_soc_pcm_stream values of the driver */
> +		stream->rates = rate_mask;
> +		stream->channels_max = max_channels;
> +		stream->formats = formats;

> +	/* copy the DAI driver to a writable area */
> +	dai_drv = devm_kzalloc(&pdev->dev, sizeof(tda998x_dai), GFP_KERNEL);
> +	if (!dai_drv)
> +		return -ENOMEM;
> +	memcpy(dai_drv, tda998x_dai, sizeof(tda998x_dai));
> +

The code should be doing this by setting constraints based on the
current setup rather than by editing the data structure - the expecation
is very much that the data won't change so this prevents surprises with
future work on the core.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/b5f17dd6/attachment.sig>
