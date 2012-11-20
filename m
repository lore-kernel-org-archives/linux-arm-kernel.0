From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 10:40:42 +0100
Subject: arm: mvebu: Various mvebu clock fixes/improvements
In-Reply-To: <20121119182701.GS14643@lunn.ch>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121119182701.GS14643@lunn.ch>
Message-ID: <20121120104042.224e51a5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Mon, 19 Nov 2012 19:27:01 +0100, Andrew Lunn wrote:

> > In summary:
> > 
> >  * Patch 1 fixes a real problem: the gating clocks are not registered
> >    on Armada 370/XP.
> > 
> >  * Patch 2, 3, 5 and 6 are more cosmetic patches, but I think they are
> >    good to have.
> > 
> >  * Patch 4 implements a fix that we've been discussing: moving the
> >    Armada XP CPU clocks down to the individual armada-xp-mv78xxx.dtsi
> >    files.
> > 
> >  * Patch 7 fixes the references to the SATA clocks on Armada
> >    370/XP. Without this patch, Armada 370 currently hangs at boot when
> >    trying to initialize SATA.
> 
> Hi Thomas
> 
> You probably want patch 1 last. Anybody bisecting this changeset if
> going to have a hung 370/XP.

Unfortunately, I don't think putting patch 1 last will work either: in
patch 7, I change the SATA clocks to point to the gating clocks. So if
patch 1 is not there, those clocks do not exist and the driver fails to
clk_get() those clocks.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
