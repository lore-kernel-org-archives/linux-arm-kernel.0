From: karl.beldan@gmail.com (Karl Beldan)
Date: Fri, 30 Sep 2016 13:15:44 +0000
Subject: [PATCH 3/6] ARM: dts: da850-lcdk: enable the LCD controller
In-Reply-To: <CAMpxmJU45aP7=vs5h6s2T=v-gB5q06AvhGJdcRV9WDgNzs+Enw@mail.gmail.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-4-git-send-email-bgolaszewski@baylibre.com>
 <20160929184001.yooxkwulqgioak6a@gobelin>
 <CAMpxmJU45aP7=vs5h6s2T=v-gB5q06AvhGJdcRV9WDgNzs+Enw@mail.gmail.com>
Message-ID: <20160930131544.265ljbjdnt2kiop3@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2016 at 11:42:14AM +0200, Bartosz Golaszewski wrote:
> 2016-09-29 20:40 GMT+02:00 Karl Beldan <karl.beldan@gmail.com>:
> > Hi,
> >
> > On Thu, Sep 29, 2016 at 06:31:52PM +0200, Bartosz Golaszewski wrote:
> >> From: Karl Beldan <kbeldan@baylibre.com>
> >>
> >> This adds the pins used by the LCD controller, and uses 'tilcdc,panel'
> >> with some default timings for 800x600.
> >>
> >> Tested on an LCDK connected on the VGA port (the LCDC is connected to
> >> this port via a THS8135).
> >>
> >> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> >> [Bartosz:
> >>   - fixed whitespace errors
> >>   - tweaked the description
> >
> > The description tweak you mention is the removal of an erratum which is
> > in the mentioned commit I put on github @
> > (https://github.com/kbeldan/linux/commit/b7720bc983c00a083dece119f68ea9d2f522c6c4)
> > it included an erratum wrt FIFO threshold I think is worth keeping:
> > {
> > There is an erratum (fifo-th) "LCDC: Underflow During Initialization":
> > [...]
> > "This problem may occur if the LCDC FIFO threshold size (
> > LCDDMA_CTRL[TH_FIFO_READY]) is left at its default value after reset.
> > Increasing the FIFO threshold size will reduce or eliminate underflows.
> > Setting the threshold size to 256 double words or larger is
> > recommended."
> > }
> 
> Isn't this the issue that is fixed by changing the memory priority for lcdc?
> 

It is possible that the erratum and the memory priority settings try to
address the symptoms of the same underlying issue, it is impossible to
state with the publicly available information, however, the erratum
relates to the LCDC registers settings, namely the fifo-th propperty of
panel-info in the dts, which is really different from the memory
priority adjustments in the SYSCFG and DDR_CTL.

Regards, 
Karl

> >
> >>   - fixed the incorrect hback-porch value
> >
> > It can't be a fix, this value depends on the monitor connected.
> >
> 
> Thanks, I'm new to drm. From reading the datasheet it seemed to me
> that this depends on the resolution. FWIW it seems that most LCDs are
> able to adjust to this themselves - I tested with two different
> displays and the value I introduced worked on both while the previous
> one shifted the image to the right. I'll look into that.
> 
> >>   - other minor tweaks]
> >
> > I didn't see any other change while diffing.
> >
> 
> Dropped the refresh rate from the timings node name.
> 
> Thanks,
> Bartosz
