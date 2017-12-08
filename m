From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 8 Dec 2017 15:30:28 +0100
Subject: [PATCH] ASoC: atmel-classd: select correct Kconfig symbol
In-Reply-To: <20171205220759.GL21780@piout.net>
References: <20171205101000.968887-1-arnd@arndb.de>
 <20171205105750.GI21780@piout.net>
 <CAK8P3a29G4T1DbkjwhEqa6cSVQL77z0jW0znMX47tqd5vM-P9Q@mail.gmail.com>
 <20171205124707.GJ21780@piout.net>
 <CAK8P3a2R+jLw3T6G_bPFeJrEQwOJu2Mu5DGXPZHRMr4LECFSsA@mail.gmail.com>
 <20171205220759.GL21780@piout.net>
Message-ID: <20171208143028.GZ21780@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2017 at 23:07:59 +0100, Alexandre Belloni wrote:
> On 05/12/2017 at 14:28:28 +0100, Arnd Bergmann wrote:
> > On Tue, Dec 5, 2017 at 1:47 PM, Alexandre Belloni
> > <alexandre.belloni@free-electrons.com> wrote:
> > > On 05/12/2017 at 12:13:41 +0100, Arnd Bergmann wrote:
> > >
> > > Ok, does that solve both randconfigs?
> > >
> > > diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> > > index 4a56f3dfba51..dcee145dd179 100644
> > > --- a/sound/soc/atmel/Kconfig
> > > +++ b/sound/soc/atmel/Kconfig
> > > @@ -64,7 +64,7 @@ config SND_AT91_SOC_SAM9X5_WM8731
> > >  config SND_ATMEL_SOC_CLASSD
> > >         tristate "Atmel ASoC driver for boards using CLASSD"
> > >         depends on ARCH_AT91 || COMPILE_TEST
> > > -       select SND_ATMEL_SOC_DMA
> > > +       select SND_SOC_GENERIC_DMAENGINE_PCM
> > >         select REGMAP_MMIO
> > >         help
> > >           Say Y if you want to add support for Atmel ASoC driver for boards using
> > 
> > Yes, that works as well and looks reliable. I've sent another
> > follow-up now, working on the
> > assumption that we actually need SND_ATMEL_SOC_DMA.
> > 
> > Both patches make it build, but obviously only one of the two is
> > actually correct. I assume you know what you are doing, so if
> > you want to send your patch with a proper changelog, please add
> > my
> > 
> > Tested-by: Arnd Bergmann <arnd@arndb.de>
> > 
> 
> Ok, I'll test on a real board before the end of the week (I need to find
> a speaker) and I'll send a proper patch.
> 

So I've tested and this works properly, I've sent the patch (as you
probably have seen).

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
