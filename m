From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 21 Feb 2011 17:00:28 +0100
Subject: [PATCH] arm: imx: Zero entire imxdma structure
In-Reply-To: <20110220230458.GA21198@n2100.arm.linux.org.uk>
References: <1298239851-958-1-git-send-email-imirkin@alum.mit.edu>
	<AANLkTin4gJpzV6-bo15rn_AHVGvTD8+9vq3Q+ciLF8vB@mail.gmail.com>
	<20110220230458.GA21198@n2100.arm.linux.org.uk>
Message-ID: <20110221160028.GQ24426@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 11:04:58PM +0000, Russell King - ARM Linux wrote:
> On Sun, Feb 20, 2011 at 10:59:24PM +0000, Ilia Mirkin wrote:
> > On Sun, Feb 20, 2011 at 10:10 PM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> > > The semantic match that finds the problem:
> > > // <smpl>
> > > @@
> > > type T;
> > > identifier x;
> > > @@
> > >
> > > T *x;
> > > ...
> > > * memset(x, ..., ... * sizeof(x) * ...);
> > > // </smpl>
> > >
> > > Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
> > >
> > > ---
> > > ?arch/arm/mach-imx/dma-v1.c | ? ?2 +-
> > > ?1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > Untested, lack of tool chain and hardware. But there's definitely something
> > > odd going on here, and this seemed like the most logical fix.
> > 
> > Doing some quick digging (as I've been discovering that a few of the
> > other patches I was planning on sending have already been sent out in
> > the past), I noticed that this same patch was already sent on Dec 9,
> > 2009 by Julia Lawall[1] (back when it was plat-mxc/dma-mx1-mx2.c), and
> > then again by Vasiliy Kulikov[2] on Oct 10, 2010.
> > 
> > On each occasion, the response was positive, but patch has yet to make
> > it upstream. Weird.
> 
> Sascha, are you going to take this patch?

Yes.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
