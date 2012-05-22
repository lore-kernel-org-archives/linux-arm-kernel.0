From: marex@denx.de (Marek Vasut)
Date: Tue, 22 May 2012 07:22:00 +0200
Subject: [PATCH v2 07/12] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <20120522044223.GJ8140@S2101-09.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <201205220620.17109.marex@denx.de>
 <20120522044223.GJ8140@S2101-09.ap.freescale.net>
Message-ID: <201205220722.00653.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, May 22, 2012 at 06:20:16AM +0200, Marek Vasut wrote:
> > Dear Shawn Guo,
> > 
> > > On 22 May 2012 11:25, Marek Vasut <marex@denx.de> wrote:
> > > > Dear Shawn Guo,
> > > > 
> > > >> Apart from my comments below, we really need to know Rob and Grant's
> > > >> opinion on this.
> > > > 
> > > > Hm ... so why don't you actually write per-board driver ? :-) That'd
> > > > handle every single board very well, you'd configure the GPIOs there,
> > > > every single additional necessary thing that has to be configured
> > > > would sink there too etc.
> > > 
> > > I'm not completely sure about how the per-board driver looks like
> > > exactly.  Can you have some code demonstrating it?
> > 
> > Well such per-board driver would handle the board-specific init, like
> > configuring the hub GPIO (as Richard has to do so on mx6q) or flick some
> > other GPIOs, configure registers etc.
> 
> So when you say driver, you just meant a C file like imx6q-sabrelite.c
> containing a number of init functions to be called by mach-imx6q.c?

Something like that ... but didn't Linus complain that we have too many files in 
arch/arm/ ?

Best regards,
Marek Vasut
