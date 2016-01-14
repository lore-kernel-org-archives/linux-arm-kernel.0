From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jan 2016 13:23:44 +0100
Subject: [PATCH] clocksource: ftm: select CLKSRC_MMIO
In-Reply-To: <56976994.2060205@linaro.org>
References: <11970328.RVc8t0Mk1C@wuerfel> <56976994.2060205@linaro.org>
Message-ID: <4788720.mjKklOJssF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 January 2016 10:25:40 Daniel Lezcano wrote:
> On 01/14/2016 12:02 AM, Arnd Bergmann wrote:
> > The ftm clocksource driver does not build if CLKSRC_MMIO is disabled:
> >
> > drivers/built-in.o: In function `ftm_timer_init':
> > (init.text+0xd324): undefined reference to `clocksource_mmio_init'
> > (init.text+0xd484): undefined reference to `clocksource_mmio_readl_up'
> >
> > This adds the same 'select' statement that the other similar drivers
> > use. Prior to allowing this driver to be enabled with COMPILE_TEST,
> > it was apparently unused. I'm not entirely sure who is using this
> > hardware, but it certainly can't hurt to ensure it builds cleanly.
> 
> Hi Arnd,
> 
> Thanks for the fix. It is already in Thomas's tree [1].

Ok, thanks for fixing it already! I'll mark this one as superceded
in my randconfig testing git tree then and will drop it as soon as
yours is merged.

	Arnd
