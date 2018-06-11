From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 11 Jun 2018 05:27:11 +0000
Subject: [PATCH v2 2/3] ASoC: simple-card: move hp and mic detection to
 soc_card probe
In-Reply-To: <20180611051559.18082-2-suzuki.katsuhiro@socionext.com>
References: <20180611051559.18082-1-suzuki.katsuhiro@socionext.com>
 <20180611051559.18082-2-suzuki.katsuhiro@socionext.com>
Message-ID: <87tvq96gnm.wl-kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Katsuhiro-san

> This patch moves headphone and microphone detection to probe() of
> snd_soc_card from init() of snd_soc_dai_link. This is because init()
> is called (and an input device /dev/input/eventX is created too)
> twice or above if simple card has two or more DAI links.
> 
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

or above ?

> -	ret = asoc_simple_card_init_hp(rtd->card, &priv->hp_jack, PREFIX);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = asoc_simple_card_init_mic(rtd->card, &priv->mic_jack, PREFIX);
> -	if (ret < 0)
> -		return ret;
(snip)
> +	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
> +	if (ret < 0)
> +		return ret;

I think we want to keep "PREFIX" ?


Best regards
---
Kuninori Morimoto
