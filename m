From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 8 Apr 2010 14:49:46 +0100
Subject: AC97 problems with pxa...
In-Reply-To: <4BBDD480.8020708@bitsim.com>
References: <4BBBACBE.7040505@bitsim.com>
	<201004070950.37809.marek.vasut@gmail.com>
	<4BBC5254.7040200@bitsim.com>
	<20100407095449.GA13576@rakim.wolfsonmicro.main>
	<4BBD9F28.9080804@bitsim.com>
	<20100408095415.GC6303@rakim.wolfsonmicro.main>
	<4BBDD480.8020708@bitsim.com>
Message-ID: <20100408134946.GD30647@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 08, 2010 at 03:05:04PM +0200, Jakob Viketoft wrote:
> Mark Brown wrote:

> Yes, it appears so, the AC97 was used by an other driver accessing
> non-sound functions on the same chip. I tried disabling the
> sound/arm ac97 part but that gives me no sound cards at all.
> Currently I have the following (with no sound card found):

> CONFIG_SND_AC97_CODEC=y
> # CONFIG_SND_AC97_POWER_SAVE is not set
> CONFIG_SND_PXA2XX_LIB_AC97=y
> # CONFIG_SND_PXA2XX_AC97 is not set
> CONFIG_SND_SOC_AC97_BUS=y
> CONFIG_SND_PXA2XX_SOC_AC97=y
> CONFIG_AC97_BUS=y

You must have at least an ASoC machine driver in there as well otherwise
these drivers are useless...  Also, could you please provide the debug
log requested previously?
