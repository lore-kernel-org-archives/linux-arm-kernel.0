From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 May 2010 16:34:21 +0900
Subject: [PATCH 05/16] ARM: S5PC100: new clocks definition
In-Reply-To: <002f01caf19e$655de6e0$3019b4a0$%szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-6-git-send-email-m.szyprowski@samsung.com>
	<001501caf18f$8bedb830$a3c92890$%kim@samsung.com>
	<002f01caf19e$655de6e0$3019b4a0$%szyprowski@samsung.com>
Message-ID: <002301caf1a5$8ccd40c0$a667c240$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
> On Wednesday, May 12, 2010 6:57 AM Kukjin Kim wrote:
> 
> > Marek Szyprowski wrote:
> > >
> > > Prepare for moving support for S5PC100 SoC to plat-s5p framework (part
3).
> > > This patch adds all clocks from plat-s5pc1xx/clocks.c and removes all
the
> > > code that can be reused from plat-s5p/clock.c.
> > >
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > ---
> > >  arch/arm/mach-s5pc100/clock.c                      |  841
> > > ++++++++++++++++----
> > >  .../include/mach}/regs-clock.h                     |    0
> > >  2 files changed, 703 insertions(+), 138 deletions(-)
> > >  copy arch/arm/{plat-s5pc1xx/include/plat =>
> > mach-s5pc100/include/mach}/regs-
> > > clock.h (100%)
> > >

(snip)

> >
> > Marek,
> >
> > Actually, need to modify many part to fit new clock scheme.
> > For example, to use clksrc_clk is easily to handle clock.
> 
> I thought I covered most of the changes. Probably only the armclk
> related functions and a cleanup in s5pc100/mach/regs-clock.h are
> left and these can be easily fixed.
> 
> > S.LSI already made the patch for C100 clock changing which is using
> > clksrc_clk structure. So may I submit it?
> 
> Could you compare your version with the final version that is created
> by my patch series? I don't think that there will be many differences
> there.
> 

There are defined clock source of C100 available clock in SYS.LSI patch like
clocks defined by CLK_SRC1 register.
SYS.LSI has covered all possible C100 clocks in our patch.

So I think SYS.LSI patch provides more functionality based on Ben Dooks' new
clock scheme.

How about check/review it after my submitting?


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
