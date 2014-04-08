From: w@1wt.eu (Willy Tarreau)
Date: Tue, 8 Apr 2014 18:05:31 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408180032.384b33b0@skate>
References: <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408155345.GC11052@1wt.eu>
 <20140408180032.384b33b0@skate>
Message-ID: <20140408160531.GD11052@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 06:00:32PM +0200, Thomas Petazzoni wrote:
> Dear Willy Tarreau,
> 
> On Tue, 8 Apr 2014 17:53:45 +0200, Willy Tarreau wrote:
> > On Tue, Apr 08, 2014 at 05:13:09PM +0200, Thomas Petazzoni wrote:
> > > Unfortunately here your patch is not sufficient to solve the problem
> > > apparently. I've fixed another problem where the return value of
> > > armada_370_xp_alloc_msi() (which is signed) is casted into an unsigned
> > > irq_hw_number_t in armada_370_xp_setup_msi_irq(), but I'm still seeing
> > > many MSIs allocated, then some freed, and finally a kernel panic.
> > 
> > I thought we already fixed that one months ago ?
> 
> Well, I don't see it fixed in mainline:
> 
>  http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-armada-370-xp.c#n130

No, I just found, I sent it to you on 23/dec/2013 as part of a private
conversation during my long debugging session on the PCIe regressions,
and since one of the patches was incorrect (revert of the mask), the
other one was lost in the noise. No problem anyway, the most important
thing is that everything is now fixed :-)

Cheers,
Willy
