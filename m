From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 24 Sep 2010 10:21:46 +0530
Subject: [PATCH 00/14] omap sram, omap4 control module and es2.0 support
In-Reply-To: <20100924011323.GC4211@atomide.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1009171147560.6562@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD307F35@dbde02.ent.ti.com>
	<20100924011323.GC4211@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD469C55@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Friday, September 24, 2010 6:43 AM
> To: Shilimkar, Santosh
> Cc: Paul Walmsley; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 00/14] omap sram, omap4 control module and es2.0
> support
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100918 00:24]:
> >  -----Original Message-----
> > > From: Paul Walmsley [mailto:paul at pwsan.com]
> > > Sent: Friday, September 17, 2010 11:21 PM
> > > To: Shilimkar, Santosh
> > > Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> > > Subject: Re: [PATCH 00/14] omap sram, omap4 control module and es2.0
> > > support
> > >
> > > Hello Santosh
> > >
> > > On Fri, 17 Sep 2010, Santosh Shilimkar wrote:
> > >
> > > > This is consolidated patch series targetted for 2.6.37 merge window.
> > > > All of these patches have been already posted/reviewed on the list.
> > >
> > > Patch 6 is missing, could you please look into why?
> > >
> > Mostly because of size of the patch, You can pick this from the
> > below git link
> >
> > > Also, please split all of the SCM changes out into a separate
> > > series/branch since they will be going in through my tree.  Am
> reviewing
> > > those now.
> > >
> > Ok done. I have split the series and kept scm changes on
> 'omap4_scm_2.6.37'
> > head and rest on 'omap_for_2.6.37'
> 
> Santosh, the "Setup MT_MEMORY and MT_MEMORY_NONCACHED L1 entries" should
> get tested in the arm tree to avoid nasty surprises. Please do the
> following
> split:
> 
> 1. A series for Russell to pull
> ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONCACHED L1 entries
> omap: Map only available sram memory
> davinci: map sram using MT_MEMORY_NONCACHED instead of MT_DEVICE
> 
> You can add my Acked-by: Tony Lindgren <tony@atomide.com> to
> the "Map only available sram memory" patch.
> 
> 2. A series for me to pull
> omap4: sram: Fix start address
> omap4: Update id.c and cpu.h for es2.0
> omap4: l2x0: Fix init parameter for es2.0
> omap4: Panda: Add DEBUG_LL support
> omap4: Fix bootup crash observed with higher CPU clocks
> 
> 3. A series for Paul to pull (already in omap4_scm_2.6.37)
> omap4: control: Add ctrl_pad_base to omap_globals
> omap4: control: Add accessor api's for pad control module
> omap4: control: Add the register definition headers
> omap4: control: Fix the control module register accesses
> 
> Please base them either on v2.6.35 or v2.6.36-rc5.
> 
Will do arrange patches as you suggested.

Regards,
Santosh
