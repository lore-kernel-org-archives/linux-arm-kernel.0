From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 25 Aug 2018 10:39:33 +0200
Subject: ASoC: pxa: remove pxa2xx-pcm driver, which caused regression
In-Reply-To: <16bb94b6-089d-f78e-1bb7-2550414be2fb@gmail.com> (Petr Cvek's
 message of "Sat, 18 Aug 2018 22:59:27 +0200")
References: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
 <87r2iwau3u.fsf@belgarion.home>
 <4deb5304-8efc-3093-7f8e-0dfe50781790@gmail.com>
 <87mutjbidr.fsf@belgarion.home>
 <16bb94b6-089d-f78e-1bb7-2550414be2fb@gmail.com>
Message-ID: <878t4u96wq.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petrcvekcz@gmail.com> writes:

> Dne 18.8.2018 v 21:10 Robert Jarzmik napsal(a):
>> Petr Cvek <petrcvekcz@gmail.com> writes:
>> 
>>> My bad I've forgot to add "select SND_PXA2XX_LIB" from removed
>>> SND_PXA2XX_SOC, now it should compile, can you test it if it works now?
>>> fixed patch in [1].
>> Still NAK.
>> 
>> You must realise that as long as you will delete sound/soc/pxa/pxa2xx-pcm.c,
>> I'll block the patch, as it is being used for music playback on several pxa
>> platforms, at least the AC97 based ones.
>> 
> I know I will send the magician only patch. I've just wanted to know how
> it is working with AC97 ;-) (+ it is still a good test for possible
> future changes).
>
>>> BTW can you try insmod-aplay-stop-rmmod with the current -next on your
>>> board?

Ok, I just did that.
I based my work on linux-next, plus one extra patch which
was lost in my last submissions :
https://groups.google.com/forum/#!topic/linux.kernel/0iw-VDxIyZk

I insmoded the modules, called aplay, heard the music, rmmoded all the modules,
then insmoded again, called aplay, and rmmoded again. Everything worked
smoothly.

Cheers.

-- 
Robert
