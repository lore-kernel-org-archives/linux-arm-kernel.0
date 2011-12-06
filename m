From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 6 Dec 2011 16:00:06 +0800
Subject: [RFC PATCH 2/3] pinctrl: imx: add pinmux-imx53 support
In-Reply-To: <20189.50504.375779.311903@ipc1.ka-ro>
References: <1322999384-7886-1-git-send-email-b29396@freescale.com>
 <1322999384-7886-2-git-send-email-b29396@freescale.com>
 <CACRpkdaYz+-nZA6atxA+5kvWOO84YeSHQPNiojq_R4zkHUGz3Q@mail.gmail.com>
 <20111205211838.GG27267@pengutronix.de>
 <20111206062500.GA3649@S2100-06.ap.freescale.net>
 <20189.50504.375779.311903@ipc1.ka-ro>
Message-ID: <20111206080005.GA3864@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 08:33:28AM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Shawn Guo writes:
> > On Mon, Dec 05, 2011 at 10:18:38PM +0100, Sascha Hauer wrote:
> > > Freescale has named the pins after their primary function which is quite
> > > confusing.
> > > 
> > > The above means:
> > > 
> > > MX53_PATA_DATA8 -> mux mode 4
> > > MX53_PATA_DATA9 -> mux mode 4
> > > ...
> > > 
> > > This brings me to the point that currently we have the pins described as
> > > 
> > > #define MX53_PAD_<name>__<function>
> > > 
> > But that's also the reason why we have so many lengthy iomux-mx*.h on
> > imx.  Taking iomux-mx53.h for example, it's a 109K header with 1219
> > LOC, but probably only 10% of the definitions will actually be used.
> > 
> Which has the benefit of having correct pin definitions for everyone
> to use. If developers who need to use currently unused pindefs have to
> create them on their own, there will always be a good chance in
> getting them wrong.

If the configuration is not working, they will notice it's wrong anyway.

> 
> > > which means that you don't have to look into the datasheet to get the
> > > different options for a pin
> > 
> > Looking at the datasheet when we write code is a pretty natural thing
> > to me.
> > 
> The pindefs are like interrupt numbers or IO addresses for which there
> also is a complete list of definitions in the kernel no matter whether
> they are actually all in use.
> 
The interrupt list is much shorter than iomux list here, which enumerate
every single function for every single pad.  Also, most interrupts stand
a pretty good chance to be used, while most of the pad functions do not.

-- 
Regards,
Shawn
