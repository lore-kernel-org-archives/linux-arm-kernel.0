From: jakob.viketoft@bitsim.com (Jakob Viketoft)
Date: Thu, 08 Apr 2010 16:06:42 +0200
Subject: AC97 problems with pxa...
In-Reply-To: <20100408134946.GD30647@rakim.wolfsonmicro.main>
References: <4BBBACBE.7040505@bitsim.com>	<201004070950.37809.marek.vasut@gmail.com>	<4BBC5254.7040200@bitsim.com>	<20100407095449.GA13576@rakim.wolfsonmicro.main>	<4BBD9F28.9080804@bitsim.com>	<20100408095415.GC6303@rakim.wolfsonmicro.main>	<4BBDD480.8020708@bitsim.com>
	<20100408134946.GD30647@rakim.wolfsonmicro.main>
Message-ID: <4BBDE2F2.60603@bitsim.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Mark Brown wrote:
> On Thu, Apr 08, 2010 at 03:05:04PM +0200, Jakob Viketoft wrote:
>> Mark Brown wrote:
> 
>> Yes, it appears so, the AC97 was used by an other driver accessing
>> non-sound functions on the same chip. I tried disabling the
>> sound/arm ac97 part but that gives me no sound cards at all.
>> Currently I have the following (with no sound card found):
> 
>> CONFIG_SND_AC97_CODEC=y
>> # CONFIG_SND_AC97_POWER_SAVE is not set
>> CONFIG_SND_PXA2XX_LIB_AC97=y
>> # CONFIG_SND_PXA2XX_AC97 is not set
>> CONFIG_SND_SOC_AC97_BUS=y
>> CONFIG_SND_PXA2XX_SOC_AC97=y
>> CONFIG_AC97_BUS=y
> 
> You must have at least an ASoC machine driver in there as well otherwise
> these drivers are useless...  Also, could you please provide the debug
> log requested previously?
> 
Sorry, I just listed the AC97 stuff. In addition there is:
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_JACK=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_ARM=y
CONFIG_SND_PXA2XX_LIB=y
CONFIG_SND_PXA2XX_LIB_AC97=y
# CONFIG_SND_PXA2XX_AC97 is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_PXA2XX_SOC=y
CONFIG_SND_PXA2XX_SOC_AC97=y
CONFIG_SND_PXA2XX_SOC_COLIBRI270_V2=y
CONFIG_SND_SOC_I2C_AND_SPI=y
# CONFIG_SND_SOC_ALL_CODECS is not set
CONFIG_SND_SOC_WM9712=y

The log output with kobject listed (do you need more info?)
kobject: 'soc-audio' (c3c20c80): kobject_add_internal: parent: 
'drivers', set: 'drivers'
kobject: 'soc-audio' (c3c20c80): kobject_uevent_env
kobject: 'soc-audio' (c3c20c80): fill_kobj_path: path = 
'/bus/platform/drivers/soc-audio'
Registered platform 'pxa2xx-audio'
kobject: 'pxa2xx-ac97' (c3c20c20): kobject_add_internal: parent: 
'drivers', set: 'drivers'
Probed pxa2xx_ac97, trying to register DAI
Registered DAI 'pxa2xx-ac97'
Registered DAI 'pxa2xx-ac97-aux'
Registered DAI 'pxa2xx-ac97-mic'
kobject: 'pxa2xx-ac97' (c3c20c20): kobject_uevent_env
kobject: 'pxa2xx-ac97' (c3c20c20): fill_kobj_path: path = 
'/bus/platform/drivers/pxa2xx-ac97'
kobject: 'colibri270-v2-asoc' (c3c20bc0): kobject_add_internal: parent: 
'drivers', set: 'drivers'
kobject: 'colibri270-v2-asoc' (c3c20bc0): kobject_uevent_env
kobject: 'colibri270-v2-asoc' (c3c20bc0): fill_kobj_path: path = 
'/bus/platform/drivers/colibri270-v2-asoc'
ALSA device list:
   No soundcards found.

It's a small step forward (the DAI gets registered), but now I need to 
find out what happened to the sound card...

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
