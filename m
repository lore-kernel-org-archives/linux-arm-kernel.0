From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 Oct 2013 09:25:45 -0400
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.13 (round 2)
In-Reply-To: <87ob6nzghi.fsf@linaro.org>
References: <20131017135409.GG22434@titan.lakedaemon.net>
 <87ob6nzghi.fsf@linaro.org>
Message-ID: <20131018132545.GK22434@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 03:20:57PM -0700, Kevin Hilman wrote:
> Jason Cooper <jason@lakedaemon.net> writes:
> 
> > Guys,
> >
> > The only thing exciting here is the workaround for the mv643xx_eth bug.
> > Whenever you shut off it's clock (and folks have good reason to do
> > this), it loses it's mac address.  In the happy, ideal boot-from-DT
> > world, this isn't a problem, since the bootloader will set
> > local-mac-address in the DT.  However, we aren't in that world (yet).
> >
> > We've been tossing around different solutions to the problem over the
> > past year or so, and this one seems a) the least painful, and b) most in
> > line with what the future will hold.  eg, the driver (on reload or
> > resume) will need to read the mac address from the DT, regardless of how
> > the mac address got there.
> >
> > thx,
> >
> > Jason.
> >
> > The following changes since commit e1cb367de27ca5c186b0f120c3c10a4a0e8edd2e:
> >
> >   ARM: kirkwood: Add standby support (2013-10-08 15:41:52 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.infradead.org/linux-mvebu.git tags/soc-3.13-2
> >
> > for you to fetch changes up to d7f5baeedbdb48d4f5bb2b4f6f56f32b7f2f7aff:
> >
> >   Documentation: arm/Marvell: clarify Armada SoCs that match 78xx0 pattern (2013-10-08 17:27:59 +0000)
> >
> > ----------------------------------------------------------------
> > mvebu soc changes for v3.13 (round 2)
> >
> >  - kirkwood
> >     - remove mbus init, pcie clk init
> >     - retain MAC addr for DT ethernet (work around broken IP)
> >     - docs: clarify Armada SoCs
> 
> Pulled into next/soc.
> 
> This had a minor conflict in board-dt.c with Sebastian's clk-of-init
> branch that's part of next/cleanup.  Please double check my conflict
> resolution (currently in our to-build branch, not yet pushed to for-next)

resolution in

  a712104 Merge branch 'next/soc' into for-next

looks good.

thx,

Jason.
