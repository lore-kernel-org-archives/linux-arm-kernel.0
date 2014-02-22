From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 22 Feb 2014 19:58:02 +0100
Subject: [GIT PULL v2] efm32 cleanups for next
In-Reply-To: <20140222003853.GG13233@quad.lixom.net>
References: <20140219201950.GC6988@pengutronix.de>
 <20140220195452.GK6988@pengutronix.de>
 <20140222003853.GG13233@quad.lixom.net>
Message-ID: <20140222185802.GS6988@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

On Fri, Feb 21, 2014 at 04:38:53PM -0800, Olof Johansson wrote:
> On Thu, Feb 20, 2014 at 08:54:52PM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > this pull request superseeds the earlier request this mail is a reply
> > to. Compared to the original one I added another cleanup. Here come the
> > full details:
> > 
> > The following changes since commit 11d73c56b96b4297bd96273e9a22b7c72d13f1fa:
> > 
> >   Merge tag 'dropmachtimexh-v2' of git://git.pengutronix.de/git/ukl/linux into next/cleanup (2014-02-18 22:19:33 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.pengutronix.de/git/ukl/linux.git tags/efm32-next
> > 
> > for you to fetch changes up to f41b0482d5c1fc05234d54d58931a606ec7a97a2:
> > 
> >   ARM: efm32: drop selecting CLKSRC_MMIO (2014-02-20 09:56:18 +0100)
> > 
> > ----------------------------------------------------------------
> > Just three simple cleanups for efm32 removing two now unused files and a
> > superflous select by ARCH_EFM32.
> > 
> > ----------------------------------------------------------------
> > BTW, I based this on armsoc/cleanup because this is the first commit
> > that allows to remove efm32's <mach/timex.h> (which is the last one in
> > the tree).
> 
> We ask you to never base your branches on top of our next/* contents, since it
> happens that it will be rebuilt. Instead you should base your branch on top of
> the topic branch in question, i.e. your timex-removal branch.
my timex-removal branch isn't enough, because it bases on v3.13-rc1
which does neither have arch/arm/mach-efm32 nor the commits that allow
to drop the select CLKSRC_MMIO nor the commit that allows to drop
<mach/entry-macro.S>.

That's why I wrote that armsoc/[next/]cleanup is the first commit that
makes my cleanups possible.

The only options I see are:
 1) merge v3.14-rc1 into my timex-series myself and base on that;
 2) wait until my timex-series enters a tree with >= 3.14-rc1 that is
    stable; or
 3) drop commit "ARM: efm32: drop unused file <mach/timex.h>" for now
    and base the rest on top of 3.14-rc1.

I did 2) assuming that next/cleanup is stable. Actually this isn't much
different from 1) because the commit I based my changes on is just
3.14-rc1 + your merge of my series. So even if you want to redo
next/cleanup throwing out some merges different than mine it shouldn't
be too hard to keep the merge you did.

The details are:

 - "ARM: efm32: drop selecting CLKSRC_MMIO" depends on
	09ca27579ee5 (clocksource: time-efm32: Select CLKSRC_MMIO)
   which is in v3.13-rc5;
 - "ARM: efm32: drop unused file <mach/timex.h>" depends on
	79f08d9ed217 (ARM: drop <mach/timex.h> for !ARCH_MULTIPLATFORM, too)
	6d85e2b0b6be (ARM: new platform for Energy Micro's EFM32 Cortex-M3 SoCs)
   so I need v3.14-rc1 + dropmachtimexh-v2 for it;
 - "ARM: efm32: drop unused file entry-macro.S" depends on
	e6d159cdf9f7 (ARM: 7890/1: v7-M: drop using mach/entry-macro.S)
   which is in v3.14-rc1.

Please advice,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
