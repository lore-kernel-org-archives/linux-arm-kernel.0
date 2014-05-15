From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 09:58:30 +0200
Subject: [PATCH v3 4/6] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <20140514212612.GK20486@codeaurora.org>
References: <1399938570-11356-1-git-send-email-matthias.bgg@gmail.com>
 <20140514070038.GG29258@lukather> <20140514212612.GK20486@codeaurora.org>
Message-ID: <4623149.HtC2qgQ8vE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 May 2014 14:26:12 Stephen Boyd wrote:
> On 05/14, Maxime Ripard wrote:
> > On Tue, May 13, 2014 at 03:47:32PM -0700, Stephen Boyd wrote:
> > > On 05/13, Matthias Brugger wrote:
> > > > +	"mediatek,mt6589",
> > > > +	NULL,
> > > > +};
> > > > +
> > > > +DT_MACHINE_START(MEDIATEK_DT, "Mediatek Cortex-A7 (Device Tree)")
> > > > +	.dt_compat	= mediatek_board_dt_compat,
> > > > +MACHINE_END
> > > 
> > > You shouldn't need this file at all if the platform is part of
> > > the multi-platform kernel.
> > 
> > From a technical point of view, you don't. But it's interesting to
> > keep it mostly for two things:
> >   - You get to see the platform name in /proc/cpuinfo
> >   - If you ever need to add platform quirks, it's already there
> > 
> > We had a similar discussion two weeks ago for mach-sunxi with Olof and
> > Arnd, and ended up keeping this minimal machine.
> > 
> 
> It looks like it's only useful to make /proc/cpuinfo have the
> platform name because it really isn't that hard to add this file
> if we need to add platform quirks. The downside is we have to
> keep adding compatibles when we support new SoCs.

We also still add Kconfig entries for each new platform, and I'd like
to leave it at that for the time being. In a lot of cases we end
up adding stuff to the machine descriptor later, e.g. for SMP support
(hopefully no more thanks to your work though).

Once we have a significant number of machines that are actually
usable rather than stubs and that we are confident about never
needing any additional pointers, we can revisit this discussion.

At that point, we should also discuss how to avoid adding a Kconfig
entry for each new platform, which e.g. involves making the
clocksource drivers user selectable. That part has been surprisingly
controversial in the past.

	Arnd
