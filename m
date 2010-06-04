From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 Jun 2010 17:22:58 +0200
Subject: [V2 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <1275644934.3210.46.camel@realization>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>
	<20100604085320.GB25357@pengutronix.de>
	<1275644934.3210.46.camel@realization>
Message-ID: <20100604152258.GC25357@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 04, 2010 at 11:48:54AM +0200, Alberto Panizzo wrote:
> On ven, 2010-06-04 at 10:53 +0200, Sascha Hauer wrote:
> > I'm not willing to accept another 3ds_debug board support in the
> > kernel
> > given that it's no rocket science to seperate this into another file
> > and
> > we still have plenty of time before the next merge window.
> > Jason, can you please move this to plat-mxc? I think we could find
> > someone else to switch the mx31_3ds support to the generic debug board
> > support then. 
> 
> Sascha, what do you mean with: switch the mx31_3ds support to the generic
> one in plat-mxc?

Only the 3ds debug board, not the mx31_3ds board as a whole.

> We are going to have a single machine file for all imx(2-3-5) based debug boards?
> I think it will look so messy..

Look at Jasons next patch, this is what I meant. We can reuse the 3ds
debug board stuff in the mx31_3ds.

> 
> I read the Linus concerns about ARM stuffs and RMK answer to your ask for pull..
> May we need to start a thread to discuss how we can restructure the imx support?

Well, the ultimate goal is to support all i.MX ports in one kernel, but
this is still a long way to go. We made quite some progress with Uwes
patches to avoid namespace collisions in the different register defines,
but there is still enough left to do. Try to tweak Kconfig to enable for
example i.MX27 and i.MX25 support and see what happens...

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
