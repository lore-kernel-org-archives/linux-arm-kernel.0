From: jakob.viketoft@bitsim.com (Jakob Viketoft)
Date: Thu, 08 Apr 2010 11:17:28 +0200
Subject: AC97 problems with pxa...
In-Reply-To: <20100407095449.GA13576@rakim.wolfsonmicro.main>
References: <4BBBACBE.7040505@bitsim.com>	<201004070950.37809.marek.vasut@gmail.com>	<4BBC5254.7040200@bitsim.com>
	<20100407095449.GA13576@rakim.wolfsonmicro.main>
Message-ID: <4BBD9F28.9080804@bitsim.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying to bring two threads down to one.

Mark Brown wrote:
> On Wed, Apr 07, 2010 at 11:37:24AM +0200, Jakob Viketoft wrote:
> 
> Please don't top post...
> 
>> Do you mean mixing the AC97 non-asoc and asoc drivers or the drivers
>> for the WM9712? I can't see the possibility of mixing anything for
>> the WM9712, but I'm unsure of the distinction between the different
>> AC97 pieces.
> 
> ...without context it's hard to work out what you are talking about.
> 
>> Should this make a difference? My module init function gets called,
>> it's just the snd_soc_dai_link[0].init function that doesn't.
> 
> Build soc-core.c with #define DEBUG at the top then look at your logs

I've run with DEBUG defined and seen a bit more specifics. I have also 
created a device in the board init and added a driver in my machine code 
as per the palmtx code. Nothing I've done seem to change the behaviour 
and I can't quite get my head around what's going on. Does anyone run a 
pxa270 board with AC97 sound and can tell me what output they get from 
dmesg?

As I said before, by writing 0 to the AC97_POWERDOWN register (enabling 
everything) I get perfect sound output, so something seems right. It 
just won't go all the way...

The dmesg output:
Registered platform 'pxa2xx-audio'
Error: Driver 'pxa2xx-ac97' is already registered, aborting...
soc-audio soc-audio: DAI pxa2xx-ac97 not registered
soc-audio soc-audio: Registered card 'Colibri 270 v2'
ALSA device list:
   #0: pxa2xx-ac97 (Wolfson WM9711,WM9712,WM9715)

The pxa2xx-ac97 DAI not being registered does seem troublesome because 
the code in soc_core won't continue without this. Any insights?

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
