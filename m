From: marex@denx.de (Marek Vasut)
Date: Tue, 25 Mar 2014 02:02:42 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140324234443.GS7528@n2100.arm.linux.org.uk>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
Message-ID: <201403250202.42268.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 25, 2014 at 12:44:43 AM, Russell King - ARM Linux wrote:
> On Mon, Mar 24, 2014 at 04:37:20PM -0600, robert.daniels at vantagecontrols.com 
wrote:
> > Marek Vasut <marex@denx.de> wrote on 03/24/2014 02:21:58 PM:
> > > I think the UDP test might be lossy, can you try with TCP test please ?
> > > 
> > > Best regards,
> > > Marek Vasut
> > 
> > Yes, I tried with TCP and there were no problems.
> > I then tried my same test with a crossover cable: no problems.
> > Then I started testing some different network configurations:
> > 
> > 1. Desktop & i.MX53 both connected to the same router: no problems.
> > 2. Desktop & i.MX53 both connected to the same hub: packet loss but no tx
> > timeout
> > 3. Desktop connected to router, hub connected to router, i.MX53 connected
> > to hub: packet loss + tx timeout
> > 
> > So, the packet loss is due to the hub, not the fec driver.
> > I'm not sure why I'm getting the tx timeout.  My router is a Cisco
> > ValetPlus and the hub is a Netgear DS108.
> > The router and desktop are gigabit and the hub is 10/100.
> > 
> > I assumed that the tx timeout should not be happening - is this an
> > incorrect assumption based on my setup?
> 
> The first point is that the timeout should not be happening, because
> when the link is up and running, packets should be transmitted.
> 
> The second point is that I think you have a setup which tickles a bug
> in the FEC hardware.  What I think is going on is that the driver is
> filling the transmit ring correctly.  For some reason, the FEC is
> either failing to update the header after transmission leaving the
> buffer owned by the FEC (and therefore unable to be reaped), or the
> FEC is skipping over a ring descriptor.

I think we might be seeing something similar on i.MX28 in U-Boot too, but I dare 
not to correlate this and the in-kernel FEC issue. We also sporadically see the 
FEC not transmitting a packet. I am just raising this since I want to update you 
all there is something like that as well.

[...]

Best regards,
Marek Vasut
