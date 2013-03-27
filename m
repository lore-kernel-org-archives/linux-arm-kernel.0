From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Mar 2013 21:17:15 +0100
Subject: [RFC PATCHv1 3/5] arm: mach-kirkwood: seperate PCIe window init
 from other windows
In-Reply-To: <20130327183534.GA9643@obsidianresearch.com>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364407504-13524-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130327183534.GA9643@obsidianresearch.com>
Message-ID: <20130327211715.27058a10@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 27 Mar 2013 12:35:34 -0600, Jason Gunthorpe wrote:
> On Wed, Mar 27, 2013 at 07:05:02PM +0100, Thomas Petazzoni wrote:
> 
> This all looks really great to me, I hope to try it as well when I get
> time. But just one small suggestion:
> 
> > diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> > index ea49476..1b4675f 100644
> > +++ b/arch/arm/mach-kirkwood/board-dt.c
> > @@ -72,6 +72,8 @@ static void __init kirkwood_of_clk_init(void)
> >  
> >  static void __init kirkwood_dt_init(void)
> >  {
> > +	int needs_pcie_wins = 1;
> > +
> >  	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
> >  
> >  	/*
> > @@ -144,6 +146,9 @@ static void __init kirkwood_dt_init(void)
> >  	if (of_machine_is_compatible("usi,topkick"))
> >  		usi_topkick_init();
> >  
> > +	if (needs_pcie_wins)
> > +		kirkwood_setup_pcie_wins();
> > +
> >  	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
> >  }
> 
> Moving the window setup into mach-kirkwood/pcie.c:kirkwood_pcie_init
> would avoid this needs_pcie_wins thing since kirkwood_pcie_init will
> naturally never be called once the other patches are applied.

Ah, yes, right. I now remember you made this suggestion when reviewing
the mvebu-mbus patch set, and I replied that I would do it when I'll
start working on using the pci-mvebu driver on Kirkwood. It looks like
it's time for me to honor this commitment :-)

Thanks for the feedback,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
