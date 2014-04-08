From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Apr 2014 18:00:32 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408155345.GC11052@1wt.eu>
References: <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408155345.GC11052@1wt.eu>
Message-ID: <20140408180032.384b33b0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Willy Tarreau,

On Tue, 8 Apr 2014 17:53:45 +0200, Willy Tarreau wrote:
> On Tue, Apr 08, 2014 at 05:13:09PM +0200, Thomas Petazzoni wrote:
> > Unfortunately here your patch is not sufficient to solve the problem
> > apparently. I've fixed another problem where the return value of
> > armada_370_xp_alloc_msi() (which is signed) is casted into an unsigned
> > irq_hw_number_t in armada_370_xp_setup_msi_irq(), but I'm still seeing
> > many MSIs allocated, then some freed, and finally a kernel panic.
> 
> I thought we already fixed that one months ago ?

Well, I don't see it fixed in mainline:

 http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-armada-370-xp.c#n130

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
