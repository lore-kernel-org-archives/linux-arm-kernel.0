From: jakob.viketoft@bitsim.com (Jakob Viketoft)
Date: Thu, 08 Apr 2010 15:05:04 +0200
Subject: AC97 problems with pxa...
In-Reply-To: <20100408095415.GC6303@rakim.wolfsonmicro.main>
References: <4BBBACBE.7040505@bitsim.com>	<201004070950.37809.marek.vasut@gmail.com>	<4BBC5254.7040200@bitsim.com>	<20100407095449.GA13576@rakim.wolfsonmicro.main>	<4BBD9F28.9080804@bitsim.com>
	<20100408095415.GC6303@rakim.wolfsonmicro.main>
Message-ID: <4BBDD480.8020708@bitsim.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Mark Brown wrote:
> On Thu, Apr 08, 2010 at 11:17:28AM +0200, Jakob Viketoft wrote:
> 
>> The dmesg output:
>> Registered platform 'pxa2xx-audio'
>> Error: Driver 'pxa2xx-ac97' is already registered, aborting...
> 
> Have you compiled in both the sound/arm and sound/soc AC97 support by
> any chance?

Yes, it appears so, the AC97 was used by an other driver accessing 
non-sound functions on the same chip. I tried disabling the sound/arm 
ac97 part but that gives me no sound cards at all. Currently I have the 
following (with no sound card found):

CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PXA2XX_LIB_AC97=y
# CONFIG_SND_PXA2XX_AC97 is not set
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_PXA2XX_SOC_AC97=y
CONFIG_AC97_BUS=y

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
