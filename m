From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Oct 2011 11:36:36 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <201110072251.40028.arnd@arndb.de>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<201110072251.40028.arnd@arndb.de>
Message-ID: <20111010103635.GA2451@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Oct 07, 2011 at 09:51:39PM +0100, Arnd Bergmann wrote:
> On Wednesday 28 September 2011, Will Deacon wrote:
> > Please pull these DEBUG_LL platform updates for 3.2. You can find the core
> > updates (actually all resident in arch/arm/Kconfig.debug) in Russell's
> > for-next branch.
> > 
> > I think Stephen Boyd was planning to move MSM to the new code as well, but
> > I've not seen any code yet so I guess that can go in later.
> 
> Hi Will,
> 
> I've tried to pull this branch, but I'm getting conflicts with patches
> from the 'CPU mapping platform updates' series you sent me earlier.
> Any idea what's going on there?

Hmm, I expect that I've inadvertently ended up basing my patches on a branch
that Russell has rebased. I mentioned this on the list at the time:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-September/063729.html

> I can certainly fix up the conflicts, but my feeling is that there is
> something wrong on your side and one of the two branches contains
> stuff from a stale version of Russell's tree.

It looks like both of the branches [cpu-mapping and debug-ll] may be out of
date now. I agree that fixing up the conflicts isn't the way to go here, but
I'm unsure what to use as my base. I depend on patches that aren't in
Russell's devel-stable branch but are in his for-next branch.

The only things I can think of are either:

 - Wait until everything has settled down, then rebase onto Russell's
   for-linus branch. This has the disadvantage that conflicts and build
   breakages won't be detected until very late.

 - Wait until the dependencies are in mainline, then rebase against that.
   Disadvantage is that it then takes twice as long to get code upstream.

 - Send another pull request against an unstable branch and hope it doesn't
   change. Disadvantage being that we have to keep repeating pull requests
   against a moving target.

I'm not especially fond of any of those though...

Do you have any other ideas?

Cheers,

Will
