From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Apr 2014 20:32:53 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408182230.GD32490@obsidianresearch.com>
References: <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate>
 <20140408171417.GB27776@obsidianresearch.com>
 <20140408200140.5dcc2ad7@skate>
 <20140408182230.GD32490@obsidianresearch.com>
Message-ID: <20140408203253.6f9b535a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 8 Apr 2014 12:22:30 -0600, Jason Gunthorpe wrote:

> > Ah correct. Though I'm still puzzled as to why the undefined behavior
> > works for me, and not for Willy, who I believe has the same NIC as me.
> 
> If we knew the algorithm in the HW it would probably make sense :)

Indeed :)

> > But I am not sure with this one. Since now you're anyway rounding down
> > sizes, how is it possible to get a non-power-of-two size in the
> > registers?
> 
> I agree, it should not happen if everything is correct, but the
> apparently correct debugfs output obscured the root cause of the
> problem..

Absolutely.

> > That being said, this warning doesn't really solve the problem that the
> > PCI core may allocate BARs whose size cannot be represented through
> > MBus windows :-)
> 
> Right, but Will pointed out it took 3 months to get to the root cause,
> so it might save that time in future :)

Yes, I completely agree, and I'm totally in favor of making things more
robust in mvebu-mbus.

Actually, should we simply return an error if something tries to set up
a window with an invalid size? But maybe it's a bit too strong for the
moment, until the power of two size problem gets resolved on the PCI
side.

But the other day, I also had funky issues with another window, and it
turned out to be caused by a non-power-of-two window as well...

> I'll revise/resend the patch.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
