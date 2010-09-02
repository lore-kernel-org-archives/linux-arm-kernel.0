From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Sep 2010 09:27:43 -0700
Subject: [PATCH 4/4] omap: Fix SMP on UP interrupt handling for multi-omap
In-Reply-To: <20100817113045.GH12184@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100817105332.19061.44765.stgit@baageli.muru.com>
	<1282043269.32205.13.camel@bnru01>
	<20100817113045.GH12184@atomide.com>
Message-ID: <20100902162743.GQ11597@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100817 04:23]:
> * srinidhi <srinidhi.kasagar@stericsson.com> [100817 14:00]:
> > On Tue, 2010-08-17 at 12:53 +0200, Tony Lindgren wrote:
> > > Fix SMP on UP interrupt handling for multi-omap
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  arch/arm/mach-omap2/include/mach/entry-macro.S |   22 ++++++++++++++++++++++
> > >  arch/arm/mach-omap2/omap-smp.c                 |   16 ++++++++++++----
> > >  arch/arm/mach-omap2/timer-gp.c                 |    7 +++++--
> > >  3 files changed, 39 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
> > > index 06e64e1..75c67aa 100644
> > > --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> > > +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
> > 
> > There is one patch lying in Russell's tracker (6284/1) which attempts to
> > use the common IRQ helper macros instead of platforms duplicating this
> > file. Perhaps you may need to re-base to that if Russell is ok with that
> > patch, of course.
> 
> Nice to see. Ideally test_for_ipi and test_for_ltirq would return
> early automatically when running SMP kernel on UP.

For the record, posted a patch to return early, so no more hacks
needed for the entry-macro.S.

Regards,

Tony
