From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Sep 2012 09:31:28 -0400
Subject: [GIT PULL V3 4/5] ARM: Kirkwood: cleanup for v3.7
In-Reply-To: <20120922051725.GB32245@quad.lixom.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120921195714.GY5469@titan.lakedaemon.net>
 <20120922051725.GB32245@quad.lixom.net>
Message-ID: <20120922133128.GD5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 10:17:25PM -0700, Olof Johansson wrote:
> On Fri, Sep 21, 2012 at 03:57:14PM -0400, Jason Cooper wrote:
> > 
> > NOTE:  This branch depends on both kirkwood/boards and kirkwood/dt (and,
> > by extension, kirkwood/addr_decode).  Some of that got pulled into this
> > summary (kirkwood/boards).  Is this correct?  Sould I be basing the
> > pullreq on v3.6-rc5?  That would summarize all three branches.  Doesn't
> > seem as useful.
> 
> What I tend to do in these cases is that I merge the dependent branches into
> a temporary working branch, then merge in the "new" branch on top, and get the
> diffstat from the last merge there.
> 
> It also looks like the base for this branch is something that is not a full
> -rc, please only base your branches on -rcs since that makes merge history much
> cleaner and easier to deal with on our side.
> 
> So, for example:
> 
> git checkout v3.6-rc5
> git merge kirkwood/boards
> git merge kirkwood/dt

Yes, that's exactly what I did.  My mistake was in my request-pull
command.  I based it on kirkwood/dt, which then caused it to list
kirkwood/boards (or, swap /dt and /boards, doesn't matter, either way is
wrong) along with the /cleanup.  Using a base of FIRSTPATCH^ seems to
work much better for generating the diffstat.  See my V4 of this pullrq.

So for V4 /cleanup:

$ git request-pull fe525da^ mvebu-infradead-pub kirkwood/cleanup
The following changes since commit 68fa6eb9d0dd41b1bb72bade6f6307193b18fbd1:

  Merge branch 'kirkwood/boards' into kirkwood/cleanup (2012-09-21 18:54:20 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git kirkwood/cleanup

Jamie Lentin (1):
      ARM: kirkwood: Trim excess #includes in board-dnskw.c

Jason Cooper (1):
      ARM: Kirkwood: ehci now specified in kirkwood.dtsi.  remove legacy platform init

 arch/arm/mach-kirkwood/board-dnskw.c          |    9 ---------
 arch/arm/mach-kirkwood/board-dockstar.c       |    1 -
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |    2 --
 arch/arm/mach-kirkwood/board-km_kirkwood.c    |    1 -
 4 files changed, 0 insertions(+), 13 deletions(-)

Obviously, this will be changing as soon as I rework /dt, drop ehci, etc.

thx,

Jason.
