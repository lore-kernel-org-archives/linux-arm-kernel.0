From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 11:53:41 -0400
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <20131001174251.11e15e43@skate>
References: <20131001004009.GK31178@titan.lakedaemon.net>
 <20131001134213.GC2448@localhost>
 <20131001135800.GS31178@titan.lakedaemon.net>
 <20131001141716.GE2448@localhost>
 <20131001150130.GT31178@titan.lakedaemon.net>
 <20131001170932.54d53aa4@skate>
 <20131001151528.GV31178@titan.lakedaemon.net>
 <20131001173358.188968e2@skate>
 <20131001153631.GX31178@titan.lakedaemon.net>
 <20131001174251.11e15e43@skate>
Message-ID: <20131001155341.GY31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 05:42:51PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 1 Oct 2013 11:36:31 -0400, Jason Cooper wrote:
> 
> > > Ah, ok. What was wrong with the idea of getting the MAC address from
> > > the hardware early at boot time, and adjust the in-memory Device Tree
> > > with this information, so that the mv643xx_eth driver can find them
> > > whenever it gets loaded, and regardless of whether clocks have been
> > > disabled or not?
> > 
> > I'm personally not opposed to that at all.  iirc, there was some
> > opposition (from Grant?) to modifying the DT from within the kernel.
> > Sorry, I can't put my finger on the objection atm.
> 
> Strange, because when we discussed the MBus DT binding, we were told
> exactly the opposite: the in-memory DT should be updated to reflect the
> MBus windows that are created dynamically (if I remember correctly).
> So it seems like updating the DT from the kernel was not really
> frowned upon (but it's true the of API does not really encourage that).

Well, MBus is by it's nature a dynamic beast, the MAC address shouldn't
be. ;-)  So I think the change was viewed as using the DT as a form of
global data storage.

At any rate, we could keep guessing, or have Ezequiel float a patch
doing just that (store the mac address in the DT if one isn't set) and
see where things stand.

I suspect the proposed patch would need to be contained within
mv643xx_eth.c as opposed to mach-kirkwood/.  Which means doing the
CLK_IGNORE_UNUSED workaround until the driver loads.

thx,

Jason.
