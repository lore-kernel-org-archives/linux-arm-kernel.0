From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 13 Oct 2011 09:17:00 +0200
Subject: [RFC][PATCH] plat-mxc: iomux-v3.h: implicitly enable
	pull-up/down when that's desired
In-Reply-To: <20111013071224.GR9395@home.lan>
References: <201110100758.p9A7wCYT011235@home.pavel.comp>
	<20111012082702.GM13898@pengutronix.de>
	<20111013071224.GR9395@home.lan>
Message-ID: <20111013071700.GQ13898@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 11:12:24AM +0400, Paul Fertser wrote:
> On Wed, Oct 12, 2011 at 10:27:02AM +0200, Sascha Hauer wrote:
> > On Mon, Oct 10, 2011 at 11:19:23AM +0400, Paul Fertser wrote:
> > > This leads to some rather hard to understand bugs such as
> > > misdetecting an absent ethernet PHY (a real bug i had)
> ...
> > > This might affect mx25, mx35, mx50, mx51 and mx53 SoCs.
> ...
> > > I'm not sure if that's really suitable for -stable so please excuse me
> > > if it's not.
> > 
> > I think it's not suitable for stable unless there is a real bug, that
> > is PUE or PKE are forgotten somewhere.
> 
> If there wasn't a real bug with MDIO, i wouldn't have found the
> problem. I've also checked all other potentially affected SoCs and all
> of them (except for the mx35, whose iomux file doesn't configure any
> pads at all) had some suspicious entries.
> 
> > I don't like that the defines which are supposed to be defines for
> > the individual bits are changed. This may lead to trouble and confusion
> > once someone wants to read the values from the iomux registers and
> > tests for bits. How about Adding new defines like this instead:
> 
> I perfectly understand the reasoning and fully agree it would be best
> to do it that way right from the beginning. But given the current
> situation when many affected iomux headers share the error that can
> lead to subtle strange bugs, i thought it might be beneficial to fix
> them all implicitly. And testing for those pull-up bits set without
> testing for PUE/PKE doesn't seem to be of any use, and also before
> sending a patch i did a git grep and found no examples of using those
> constants in an unexpected way.

Ok, convinced. Let's go with your patch for now as it's the least
intrusive way to deal with it. Still I think we should change this
as I suggested later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
