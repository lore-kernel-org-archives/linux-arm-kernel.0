From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 May 2018 08:39:56 -0700
Subject: [PATCH] ARM: dts: omap3-beagle-xm: Add fixed 26MHz clock as fck
 for twl
In-Reply-To: <CAHCN7x+Ow7B4kTmd+4PkDd=azn-qKMYmEyjqfb8GkXA7Y7pEPA@mail.gmail.com>
References: <20180405115239.17370-1-peter.ujfalusi@ti.com>
 <CAHCN7x+Ow7B4kTmd+4PkDd=azn-qKMYmEyjqfb8GkXA7Y7pEPA@mail.gmail.com>
Message-ID: <20180501153956.GG98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adam Ford <aford173@gmail.com> [180501 15:32]:
> On Thu, Apr 5, 2018 at 6:52 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > The board uses 26MHz oscillator for the twl4030 HFCLK.
> > This way we will not depend on the bootloader to configure the
> > CFG_BOOT:HFCLK_FREQ
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> > Hi,
> >
> > there might be other boards (all omap3 boards with twl4030?) which uses the same
> > setup, but I only have schematics for beagle-xm.
> >
> 
> I know I am late coming into this, but we have twl4030_omap3.dtsi for
> the items common to omap3. Can we put the clock reference in that
> file?
> 
> It seems like it would be cleaner than having a dozen boards or so
> boards having the exact same copy of the same stuff. SHould something
> change in the future, I would think it would make
> maintenance easier too.  Just my two cents.

Well we don't know if it's a 26MiHz clock on all of them. Some use
38MiHz at least. Sure the board can override it but let's first
fix up each board then later on add the common node.

Regards,

Tony
