From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jun 2016 20:13:22 +0100
Subject: [alsa-devel] [PATCH v5 6/9] ASoC: mediatek: add mt2701 platform
 driver implementation.
In-Reply-To: <1466149440-23889-7-git-send-email-garlic.tseng@mediatek.com>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-7-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <20160629191322.GT6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 03:43:57PM +0800, Garlic Tseng wrote:

> +static int mt2701_afe_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id,
> +				     int div)
> +{

Why are we adding a set_clkdiv() operation?  I would expect the driver
to be able to figure things out automatically.

> +	case DIV_ID_MCLK_TO_BCK:
> +		afe_priv->i2s_path[i2s_num].div_mclk_to_bck = div;
> +		break;
> +	case DIV_ID_BCK_TO_LRCK:
> +		afe_priv->i2s_path[i2s_num].div_bck_to_lrck = div;
> +		break;

Especially in the case where we're configuring LRCLK, that's trivial
when we know the sample rate which we have to know anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160629/ec6c3bdd/attachment-0001.sig>
