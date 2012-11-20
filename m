From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 17:22:16 +0100
Subject: arm: mvebu: Various mvebu clock fixes/improvements
In-Reply-To: <20121119182701.GS14643@lunn.ch>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121119182701.GS14643@lunn.ch>
Message-ID: <20121120172216.7a613162@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Mon, 19 Nov 2012 19:27:01 +0100, Andrew Lunn wrote:

> >  * Patch 1 fixes a real problem: the gating clocks are not
> > registered on Armada 370/XP.
> > 
> >  * Patch 2, 3, 5 and 6 are more cosmetic patches, but I think they
> > are good to have.
> > 
> >  * Patch 4 implements a fix that we've been discussing: moving the
> >    Armada XP CPU clocks down to the individual
> > armada-xp-mv78xxx.dtsi files.
> > 
> >  * Patch 7 fixes the references to the SATA clocks on Armada
> >    370/XP. Without this patch, Armada 370 currently hangs at boot
> > when trying to initialize SATA.
> 
> Hi Thomas
> 
> You probably want patch 1 last. Anybody bisecting this changeset if
> going to have a hung 370/XP.

In the end, here is how I fixed this:

 * The clk patches are going to be pulled first by Jason. It enables
   gating clocks on all platforms, and it boots fine on Armada 370,
   Armada XP and Kirkwood.

 * The entire Armada 370/XP SATA patches are going to be pulled by
   Jason *after* the clk patches. So the SATA DT entries will from the
   beginning have the correct 'clocks' property, so that when you boot
   clk + sata, it works ok on Armada 370 and Armada XP.

I hope that's ok for you.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
