From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 13 May 2010 01:59:10 +0100
Subject: [PATCH 05/16] ARM: S5PC100: new clocks definition
In-Reply-To: <000301caf1ae$72b04a80$5810df80$%szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-6-git-send-email-m.szyprowski@samsung.com>
	<001501caf18f$8bedb830$a3c92890$%kim@samsung.com>
	<002f01caf19e$655de6e0$3019b4a0$%szyprowski@samsung.com>
	<002301caf1a5$8ccd40c0$a667c240$%kim@samsung.com>
	<000301caf1ae$72b04a80$5810df80$%szyprowski@samsung.com>
Message-ID: <20100513005910.GO6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 10:37:59AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> On Wednesday, May 12, 2010 9:34 AM Kukjin Kim wrote:
> 
> > ...
> > > >
> > > > Marek,
> > > >
> > > > Actually, need to modify many part to fit new clock scheme.
> > > > For example, to use clksrc_clk is easily to handle clock.
> > >
> > > I thought I covered most of the changes. Probably only the armclk
> > > related functions and a cleanup in s5pc100/mach/regs-clock.h are
> > > left and these can be easily fixed.
> > >
> > > > S.LSI already made the patch for C100 clock changing which is using
> > > > clksrc_clk structure. So may I submit it?
> > >
> > > Could you compare your version with the final version that is created
> > > by my patch series? I don't think that there will be many differences
> > > there.
> > >
> > 
> > There are defined clock source of C100 available clock in SYS.LSI patch
> > like
> > clocks defined by CLK_SRC1 register.
> > SYS.LSI has covered all possible C100 clocks in our patch.
> 
> So this is rather a question of general policy about the clocks. Do we
> really need to define them even if no driver would use it? I'm not
> convinced. On the other hand defining all clocks now may reduce the driver
> development time in the future. 

I've not really got a policy on this, when adding new SoC support I
much prefer to see what is needed to get the archicture core up before
adding lots of clocks.
  
> > So I think SYS.LSI patch provides more functionality based on Ben Dooks'
> > new clock scheme.
> > 
> > How about check/review it after my submitting?
> 
> Maybe it would be possible to adapt it in such a way that it would be an
> extension to the clocks defined by my patch series?
> 
> Ben, what do you think? Which way should we go?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
