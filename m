From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Dec 2010 12:46:37 +0000
Subject: [PATCH 1/3] ASoC: EP93xx I2S and PCM fixes
In-Reply-To: <1291809693.31916.2.camel@r60e>
References: <1291809693.31916.2.camel@r60e>
Message-ID: <20101208124637.GD16418@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 03:01:33PM +0300, Alexander wrote:

> Changes to I2S code:

This should be split into a patch series, there's a bunch of changes
here that are pretty much unrelated.  Having everything in one patch
makes review harder as more changes have to be thought about
simultaneously and means that the different changes get tied up with
each other and a problem with one can hold up others.

> - MCLK is turned on on driver probe. This is done for several codecs that need this for 
>   registers access (like CS4271).

This seems like a retrograde step for systems that don't need it.  Would
it not be better to make this configurable by the machine driver?

> - SCLK and LRCLK rates are corrected, assuming we always send 32 bits * 2 channels to codec.

What was the problem?

> - Formats list shortened to just S32_LE, this makes all the DMA transactions right,
>   while ALSA will do all sample format translation for us.

Again, what was the actual problem?  32 bit samples seem very large if
the hardware is capable of other formats, especially given that things
like MP3 tend to produce 16 bit data.
