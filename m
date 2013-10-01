From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 11:36:31 -0400
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <20131001173358.188968e2@skate>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001004009.GK31178@titan.lakedaemon.net>
 <20131001134213.GC2448@localhost>
 <20131001135800.GS31178@titan.lakedaemon.net>
 <20131001141716.GE2448@localhost>
 <20131001150130.GT31178@titan.lakedaemon.net>
 <20131001170932.54d53aa4@skate>
 <20131001151528.GV31178@titan.lakedaemon.net>
 <20131001173358.188968e2@skate>
Message-ID: <20131001153631.GX31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 05:33:58PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 1 Oct 2013 11:15:28 -0400, Jason Cooper wrote:
> 
> > > Sorry for jumping into the discussion, but how does that solve the case
> > > when the driver is loaded as a module, and therefore unused clocks are
> > > disabled before the driver ->probe() function gets called?
> > 
> > Sorry, I wrote the reply to JasonG just moments before and assumed a
> > little knowledge of that in this reply.
> > 
> > We would use Ezequiel's patch to ensure CLK_IGNORE_UNUSED is set for the
> > clock during boot, then, after boot, mv643xx_eth's probe would look for
> > the mac address in the DT.  If it's there, it would unset the flag
> > knowing that it can recover the mac address from the DT.  Then we could
> > get the power savings from suspend/unload.
> 
> Ah, ok. What was wrong with the idea of getting the MAC address from
> the hardware early at boot time, and adjust the in-memory Device Tree
> with this information, so that the mv643xx_eth driver can find them
> whenever it gets loaded, and regardless of whether clocks have been
> disabled or not?

I'm personally not opposed to that at all.  iirc, there was some
opposition (from Grant?) to modifying the DT from within the kernel.
Sorry, I can't put my finger on the objection atm.

thx,

Jason.
