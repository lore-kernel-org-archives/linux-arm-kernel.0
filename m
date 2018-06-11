From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Mon, 11 Jun 2018 14:39:50 +0900
Subject: [PATCH v2 2/3] ASoC: simple-card: move hp and mic detection to
 soc_card probe
In-Reply-To: <87tvq96gnm.wl-kuninori.morimoto.gx@renesas.com>
References: <20180611051559.18082-1-suzuki.katsuhiro@socionext.com>	<20180611051559.18082-2-suzuki.katsuhiro@socionext.com>
 <87tvq96gnm.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <007401d40146$9ddaaec0$d9900c40$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Morimoto-san,

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, June 11, 2018 2:27 PM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: Mark Brown <broonie@kernel.org>; alsa-devel at alsa-project.org; Masami
Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v2 2/3] ASoC: simple-card: move hp and mic detection to
soc_card
> probe
> 
> 
> Hi Katsuhiro-san
> 
> > This patch moves headphone and microphone detection to probe() of
> > snd_soc_card from init() of snd_soc_dai_link. This is because init()
> > is called (and an input device /dev/input/eventX is created too)
> > twice or above if simple card has two or more DAI links.
> >
> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> 
> or above ?
> 

It seems if simple card has multiple DAI links, it creates multiple input 
devices.

For example simple card has 3-links, 3 input devices /dev/input/event0,
event1, event2 are created. Is it correct?


> > -	ret = asoc_simple_card_init_hp(rtd->card, &priv->hp_jack, PREFIX);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	ret = asoc_simple_card_init_mic(rtd->card, &priv->mic_jack, PREFIX);
> > -	if (ret < 0)
> > -		return ret;
> (snip)
> > +	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
> > +	if (ret < 0)
> > +		return ret;
> 
> I think we want to keep "PREFIX" ?
> 

Oops... Thank you. I'll fix it.


Regards,
--
Katsuhiro Suzuki


> 
> Best regards
> ---
> Kuninori Morimoto
