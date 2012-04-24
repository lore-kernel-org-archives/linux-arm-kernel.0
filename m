From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Apr 2012 08:54:26 +0100
Subject: [PATCH 1/3] ARM: imx: Add common imx cpuidle init functionality.
In-Reply-To: <20120424013841.GB26306@S2101-09.ap.freescale.net>
References: <20120420020816.GH22219@S2101-09.ap.freescale.net>
 <CAMXH7KE2RtdNy3G61guZb2uWy3rn267Z3eEVEgN5e==tHHsiuA@mail.gmail.com>
 <20120423051813.GM26306@S2101-09.ap.freescale.net>
 <20120423062739.GX3852@pengutronix.de>
 <20120423065259.GR26306@S2101-09.ap.freescale.net>
 <20120423065623.GA3852@pengutronix.de>
 <20120423071013.GS26306@S2101-09.ap.freescale.net>
 <20120423074856.GU20478@pengutronix.de>
 <CAMXH7KH1pwh7hJ=T30zxcWcx19wjXvr6Ff4OLy7fzqY5p79Fwg@mail.gmail.com>
 <20120424013841.GB26306@S2101-09.ap.freescale.net>
Message-ID: <20120424075426.GP24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 09:38:43AM +0800, Shawn Guo wrote:
> On Mon, Apr 23, 2012 at 10:45:02AM -0500, Rob Lee wrote:
> > >> Let me try last time. ?What about having a late_initcall hook in
> > >> machine_desc?
> > >
> > > Also fine with me.
> > >
> > 
> > Shall I add Shawn's patch to my imx cpuidle patchset or should the
> > arch/arm/kernel/setup.c and arch.h changes be submitted separately?
> > If separately, Shawn, did you want to submit this patch or should I?
> > 
> Strange.  Russell is not in the Cc list.  I remember I added Russell
> into Cc when I propose the idea.  Added him again.

I didn't see any message in this thread cc'd to me, but that's not to
say I hadn't already read this patch.  I don't have any comment against
it, but I do wonder how often this hook would be used.

We do seem to have quite a number of late_initcall()s in arch/arm/mach-*,
so it seems to be a good idea - provided someone's willing to convert all
those users of late_initcall()s.
