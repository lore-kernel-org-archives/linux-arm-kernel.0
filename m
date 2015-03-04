From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 23:36:16 +0100
Subject: [PATCH] net: smc91x: use run-time configuration on all ARM
 machines
In-Reply-To: <20150228.125721.1605776377351425463.davem@davemloft.net>
References: <2226303.iMQTNXSl1n@wuerfel>
 <20150228.125721.1605776377351425463.davem@davemloft.net>
Message-ID: <55454365.1GsbtFBXGk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 February 2015 12:57:21 David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 25 Feb 2015 16:31:57 +0100
> 
> > The smc91x driver traditionally gets configured at compile-time
> > for whichever hardware it runs on. This no longer works on
> > ARM as we continue to move to building all-in-one kernels.
> > 
> > Most ARM configurations with this driver already use run-time
> > configuration through DT or through platform_data, but a
> > few have not been converted yet.
> > 
> > I've checked all ARM boards that use this driver in their
> > legacy board files, and converted the ones that were using
> > compile-time configuration in smc91x.h to behave like the
> > other ones and provide the interrupt polarity along with
> > the MMIO configuration (width, stride) at platform device
> > creation time.
> > 
> > In particular, these combinations were previously selectable
> > in Kconfig but in fact broken:
> > 
> > - sa1100 assabet plus pleb
> > - msm combined with any other armv6/v7 platform
> > - pxa-idp combined with any non-DMA pxa variant
> > - LogicPD PXA270 combined with any other pxa
> > - nomadik combined with any other armv4/v5 platform,
> >   e.g. versatile.
> > 
> > None of these seem critical enough to warrant a backport
> > to stable, but it would be nice to clean this up for good.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Applied, thanks Arnd.
> 

It seems my build testing went wrong and although I was building
lots of kernels, it did not catch the obvious typos I introduced.

I'm deeply sorry about that, following up with a fix now (which
was actually tested).

	Arnd
