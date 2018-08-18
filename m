From: petrcvekcz@gmail.com (Petr Cvek)
Date: Sat, 18 Aug 2018 22:59:27 +0200
Subject: ASoC: pxa: remove pxa2xx-pcm driver, which caused regression
In-Reply-To: <87mutjbidr.fsf@belgarion.home>
References: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
 <87r2iwau3u.fsf@belgarion.home>
 <4deb5304-8efc-3093-7f8e-0dfe50781790@gmail.com>
 <87mutjbidr.fsf@belgarion.home>
Message-ID: <16bb94b6-089d-f78e-1bb7-2550414be2fb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Dne 18.8.2018 v 21:10 Robert Jarzmik napsal(a):
> Petr Cvek <petrcvekcz@gmail.com> writes:
> 
>> My bad I've forgot to add "select SND_PXA2XX_LIB" from removed
>> SND_PXA2XX_SOC, now it should compile, can you test it if it works now?
>> fixed patch in [1].
> Still NAK.
> 
> You must realise that as long as you will delete sound/soc/pxa/pxa2xx-pcm.c,
> I'll block the patch, as it is being used for music playback on several pxa
> platforms, at least the AC97 based ones.
> 
I know I will send the magician only patch. I've just wanted to know how
it is working with AC97 ;-) (+ it is still a good test for possible
future changes).

>> BTW can you try insmod-aplay-stop-rmmod with the current -next on your
>> board?
> Insmod/rmmod which module exactly ?
> 	regmap-ac97.ko
> 	ac97.ko
> 	snd-pcm-dmaengine.ko
> 	snd-pxa2xx-lib.ko
> 	snd-soc-wm9713.ko
> 	snd-soc-pxa2xx.ko
> 	snd-soc-pxa2xx-ac97.ko
> 	snd-soc-mioa701.ko
> 
This one: snd-soc-pxa2xx-ac97.ko, but the kernel makes oops right after
you terminate aplay.

best regards,
Petr
