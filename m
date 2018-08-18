From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 18 Aug 2018 21:10:40 +0200
Subject: ASoC: pxa: remove pxa2xx-pcm driver, which caused regression
In-Reply-To: <4deb5304-8efc-3093-7f8e-0dfe50781790@gmail.com> (Petr Cvek's
 message of "Sat, 18 Aug 2018 15:00:29 +0200")
References: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
 <87r2iwau3u.fsf@belgarion.home>
 <4deb5304-8efc-3093-7f8e-0dfe50781790@gmail.com>
Message-ID: <87mutjbidr.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petrcvekcz@gmail.com> writes:

> My bad I've forgot to add "select SND_PXA2XX_LIB" from removed
> SND_PXA2XX_SOC, now it should compile, can you test it if it works now?
> fixed patch in [1].
Still NAK.

You must realise that as long as you will delete sound/soc/pxa/pxa2xx-pcm.c,
I'll block the patch, as it is being used for music playback on several pxa
platforms, at least the AC97 based ones.

> BTW can you try insmod-aplay-stop-rmmod with the current -next on your
> board?
Insmod/rmmod which module exactly ?
	regmap-ac97.ko
	ac97.ko
	snd-pcm-dmaengine.ko
	snd-pxa2xx-lib.ko
	snd-soc-wm9713.ko
	snd-soc-pxa2xx.ko
	snd-soc-pxa2xx-ac97.ko
	snd-soc-mioa701.ko

> OK I can do that, (I can speak only for I2S and SSP) but if fixed patch
> work it should be fine.
Nope, it still impacts the AC97 based boards.

Cheers.

--
Robert
