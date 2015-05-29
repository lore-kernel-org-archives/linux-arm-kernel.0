From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 16:28:53 +0200
Subject: [GIT PULL] ARM: mediatek: arm64 updates for v4.2
In-Reply-To: <20150529125829.GE6325@pengutronix.de>
References: <CABuKBeLhFR=94cF301wL7J8hJVTtyseoD7g45PLE6znQkPAFGQ@mail.gmail.com>
 <4904430.YVNgRyyb6C@wuerfel> <20150529125829.GE6325@pengutronix.de>
Message-ID: <2560864.dSIGJOm4yU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 May 2015 14:58:29 Sascha Hauer wrote:
> On Fri, May 29, 2015 at 02:07:40PM +0200, Arnd Bergmann wrote:
> > On Friday 29 May 2015 14:04:32 Arnd Bergmann wrote:
> > > On Wednesday 27 May 2015 17:14:08 Matthias Brugger wrote:
> > > > - dts: fixup pinctrl mt8173
> > > > - dts: mt8173-evb fix model name
> > > > - dts: mt8173 fix identation
> > > > - dts: mt8173 add clock controller
> > > > - dts: mt8173 change uart clocks
> > > > - dts: mt8173 add pmic wrapper
> > > > 
> > > 
> > > Pulled into next/dt, thanks!
> > > 
> > 
> > Dropped it again, after getting a build error:
> > 
> >   DTC     arch/arm64/boot/dts/mediatek/mt8173-evb.dtb
> > In file included from ../arch/arm64/boot/dts/mediatek/mt8173-evb.dts:16:0:
> > ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:14:42: fatal error: dt-bindings/clock/mt8173-clk.h: No such file or directory
> >  #include <dt-bindings/clock/mt8173-clk.h>
> >                                           ^
> > 
> > Please fix and resubmit.
> 
> These come from the clk tree. My original suggestion was to pull in this
> dts changes late after -rc1.

Please don't do it that way. If you can't figure out a way to
avoid the dependency, just stage it out over an extra merge window
and add the driver first and the dt changes the next time.

> Other possibility: Stephen, can you provide
> a stable commit containing the Mediatek clk changes?

That would work.

	Arnd
