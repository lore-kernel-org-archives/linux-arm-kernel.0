From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 09:36:16 +0100
Subject: [PATCH] ASoC: rcar: remove unused variable
In-Reply-To: <878u5m8ut0.wl%kuninori.morimoto.gx@renesas.com>
References: <4929159.b95vLdVRYU@wuerfel>
 <878u5m8ut0.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <4083363.2bJPz8BMy4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 06:25:36 Kuninori Morimoto wrote:
> 
> Hi Arnd, Mark
> 
> > After a recent cleanup, the soc_card variable became unused
> > and now produces a warning:
> > 
> > soc/sh/rcar/core.c: In function '__rsnd_kctrl_new':
> > soc/sh/rcar/core.c:801:23: warning: unused variable 'soc_card' [-Wunused-variable]
> > 
> > This removes the variable.
> > 
> > Fixes: 1a497983a5ae ("ASoC: Change the PCM runtime array to a list")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
> > index c6685f14b9cb..90b244c1f526 100644
> > --- a/sound/soc/sh/rcar/core.c
> > +++ b/sound/soc/sh/rcar/core.c
> > @@ -798,7 +798,6 @@ static int __rsnd_kctrl_new(struct rsnd_mod *mod,
> >  			    void (*update)(struct rsnd_dai_stream *io,
> >  					   struct rsnd_mod *mod))
> >  {
> > -	struct snd_soc_card *soc_card = rtd->card;
> >  	struct snd_card *card = rtd->card->snd_card;
> >  	struct snd_kcontrol *kctrl;
> >  	struct snd_kcontrol_new knew = {
> 
> It seems this patch was accepted to topic/rcar branch,
> but I got compile error
> 
> /opt/home/morimoto/WORK/linux/sound/soc/sh/rcar/core.c: In function '__rsnd_kctrl_new':
> /opt/home/morimoto/WORK/linux/sound/soc/sh/rcar/core.c:807:18: error: 'soc_card' undeclared (first use in this function)
>    .index  = rtd - soc_card->rtd,
>                   ^
> /opt/home/morimoto/WORK/linux/sound/soc/sh/rcar/core.c:807:18: note: each undeclared identifier is reported only once for each function it appears in
> make[6]: *** [sound/soc/sh/rcar/core.o] ??? 1
> make[6]: *** ??????????????....
> make[5]: *** [sound/soc/sh/rcar] ??? 2
> make[4]: *** [sound/soc/sh] ??? 2
> 
> This __rsnd_kctrl_new() is using "soc_card"...

It looks like the commit that removed the user of that variable is in the
"topic/pcm-list" branch instead of "topic/rcar".

	Arnd
