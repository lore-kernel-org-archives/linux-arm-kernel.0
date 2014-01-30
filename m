From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Jan 2014 21:02:08 +0000
Subject: [PATCH v2 2/5] ASoC: tda998x: add a codec driver for TDA998x
In-Reply-To: <c638b6622f4e059987f075091716a2305217ee49.1391081934.git.moinejf@free.fr>
References: <cover.1391081933.git.moinejf@free.fr>
 <c638b6622f4e059987f075091716a2305217ee49.1391081934.git.moinejf@free.fr>
Message-ID: <20140130210208.GY22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 26, 2014 at 07:45:36PM +0100, Jean-Francois Moine wrote:

> +static void tda_get_encoder(struct tda_priv *priv)
> +{
> +	struct snd_soc_codec *codec = priv->codec;
> +	struct device_node *np;
> +	struct i2c_client *i2c_client;
> +	static const struct of_device_id tda_dt[] = {
> +		{ .compatible = "nxp,tda998x" },
> +		{ },
> +	};
> +
> +	/* search the tda998x device */
> +	np = of_find_matching_node_and_match(NULL, tda_dt, NULL);
> +	if (!np || !of_device_is_available(np)) {
> +		dev_err(codec->dev, "No tda998x in DT\n");
> +		return;
> +	}
> +	i2c_client = of_find_i2c_device_by_node(np);

Like I said last time I'd really expect this to look like a MFD (or
generally a proper CODEC driver) so we don't get this weird probe
ordering stuff.  If you don't think that's sensible for some reason it'd
be helpful to understand why.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140130/875438f4/attachment.sig>
