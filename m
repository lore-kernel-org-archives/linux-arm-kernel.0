From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 02 Sep 2011 09:13:09 -0400 (EDT)
Subject: [GIT PULL] CPU mapping platform updates for 3.2
In-Reply-To: <20110902083817.GA11728@e102144-lin.cambridge.arm.com>
References: <20110901211107.GB5209@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1109012331010.20358@xanadu.home>
	<20110902083817.GA11728@e102144-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1109020908250.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Sep 2011, Will Deacon wrote:

> Hi Nicolas,
> 
> On Fri, Sep 02, 2011 at 04:34:25AM +0100, Nicolas Pitre wrote:
> > On Thu, 1 Sep 2011, Will Deacon wrote:
> > 
> > > Hi Arnd,
> > > 
> > > Please pull the following CPU mapping patches for 3.2. Russell has merged
> > > the core changes into his for-next branch, so this pull is based against
> > > that (following the merging discussion we had previously). I can rebase
> > > onto next/master if you prefer.
> > > 
> > > Cheers,
> > > 
> > > Will
> > > 
> > > 
> > > The following changes since commit 3ad29450aa243a318fae5d50bdc918760436bb02:
> > > 
> > >   Merge branch 'devel-stable' into for-next (2011-08-28 10:41:19 +0100)
> > 
> > No, please don't use that as a base.  This commit is likely to vanish 
> > the next time RMK reconstructs his for-next branch.  You should instead 
> > base those patches on the actual branch tip that RMK merged from you.
> 
> D'oh, I thought this might happen. The problem I have is that my core
> patches depend on one from Vincent Guittot ("ARM: 7011/1: Add ARM cpu
> topology definition"), so I ended up sending my changes via Russell's patch
> system.
> 
> How about I cherry pick Vincent's patch and my core changes out of next and
> use that as a base (on top of -rc4)?

I would instead suggest that you simply use commit c2b9ab71c6 as your 
base.  It is more likely to remain stable, unlike the top commit in the 
for-next branch.

Cherry-picking needed commits would work, but they would end up being 
duplicated in two different branches in the final Git history.  Git can 
cope with that of course, but this is usually something we try to avoid 
as this could create some confusion for people.


Nicolas
