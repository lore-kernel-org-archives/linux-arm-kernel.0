From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 27 Jan 2014 09:16:12 +0100
Subject: [PATCH 0/2] DT updates for Hummingboard and new Cubox-i
In-Reply-To: <CAOesGMhp1S-XJjGZQBPmH7RFT_pobSFLTBT+4fSKdZ3zhukEhA@mail.gmail.com>
References: <20140116182211.GX15937@n2100.arm.linux.org.uk>
 <20140119031816.GD16158@S2101-09.ap.freescale.net>
 <20140119185246.GB28056@quad.lixom.net>
 <20140124150927.GA2780@S2101-09.ap.freescale.net>
 <CAOesGMhp1S-XJjGZQBPmH7RFT_pobSFLTBT+4fSKdZ3zhukEhA@mail.gmail.com>
Message-ID: <1390810572.4847.4.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 24.01.2014, 19:44 -0800 schrieb Olof Johansson:
> Hi,
> 
> On Fri, Jan 24, 2014 at 7:09 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Sun, Jan 19, 2014 at 10:52:46AM -0800, Olof Johansson wrote:
> >> I'm well aware that the DT branch has not been merged, and that's because
> >> there has been no consensus from DT maintainers on the massive rework
> >> you did as the base of the branch.
> >
> > I guess the 'massive rework' you're talking about is the patch series
> > that begins with 'ARM: dts: imx6qdl: make pinctrl nodes board specific'?
> > If so, I hope you would agree that we're trying to solve a real
> > problem [1], even though the solution does not look like the best to
> > you.
> >
> > So which specific part of the solution are you objecting to?  Those
> > MX6QDL_*_PINGRP macros defined in imx6qdl-pingrp.h?  If that's the
> > case, I can send a follow-up patch to kill the macros by filling in the
> > pin group definitions directly.  The pros is that the pin group
> > definitions for given board will be more intuitive, and the cons is that
> > the change set will be even more massive, because the same multi-lines
> > pin group definitions will be duplicated in multiple board dts files,
> > which use the same group of pins for given device.
> >
> > Or any other better idea?
> 
> I haven't heard any other maintainers being positive to this change.
> Not Linus W, as the pinctrl maintainer, and none of the DT
> maintainers. I asked for their review, which should mean acks or
> general approval from them, and I haven't seen any come in. Or did I
> miss it?
> 

Just to throw in some opinion: we at Pengutronix use the new macros for
some time now and we pretty much like them. We are even in the process
of pushing them to our bootloader. They do not obfuscate things beyond
the status quo, as we always needed some form of grouping. Now it's just
a macro, before it was a phandle.

Also those are not changing ABI, so if people really hate them (which I
seriously doubt) we can always revert or change them to something other
later. So IMHO I would really like the change to go in as is.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
