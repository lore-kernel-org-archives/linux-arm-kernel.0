From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 1 Oct 2013 17:42:51 +0200
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <20131001153631.GX31178@titan.lakedaemon.net>
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
 <20131001153631.GX31178@titan.lakedaemon.net>
Message-ID: <20131001174251.11e15e43@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 1 Oct 2013 11:36:31 -0400, Jason Cooper wrote:

> > Ah, ok. What was wrong with the idea of getting the MAC address from
> > the hardware early at boot time, and adjust the in-memory Device Tree
> > with this information, so that the mv643xx_eth driver can find them
> > whenever it gets loaded, and regardless of whether clocks have been
> > disabled or not?
> 
> I'm personally not opposed to that at all.  iirc, there was some
> opposition (from Grant?) to modifying the DT from within the kernel.
> Sorry, I can't put my finger on the objection atm.

Strange, because when we discussed the MBus DT binding, we were told
exactly the opposite: the in-memory DT should be updated to reflect the
MBus windows that are created dynamically (if I remember correctly).
So it seems like updating the DT from the kernel was not really
frowned upon (but it's true the of API does not really encourage that).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
