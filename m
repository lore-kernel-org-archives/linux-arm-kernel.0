From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Oct 2011 23:17:08 +0200
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <4EA08DD0.1090706@gmail.com>
References: <4E97A601.1020005@gmail.com>
	<20111020185612.GD21648@n2100.arm.linux.org.uk>
	<4EA08DD0.1090706@gmail.com>
Message-ID: <4222689.nWCbSCrufR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 October 2011 16:08:32 Rob Herring wrote:
> > unintended dependencies.  That's got to be a good thing.
> 
> Understood, but from a git perspective the commit ids have changed.
> While git can deal with trivial re-commits like this, my understanding
> is that should be avoided for upstream merges. Otherwise, I could just
> cherry-pick them and re-commit them in my tree.
> 
> Ultimately, the people working off of those branches do need them to be
> stable to merge their branches. So are you saying your l2x0 branch
> (91c2ebb90b1890abc648ba9dec5608cbc97e1cb9) is now stable? Can you
> publish it as a branch. iMX6Q is also dependent on it.

The point is that Russell's 'misc' branch is not stable, which helps a lot
because it lets him commit stuff early for testing and then take it out
again when it turns out to be buggy. The for-next branch in Russell's
tree is not stable and gets recreated by pulling in the other branches.
This is similar to what I do with the arm-soc for-next branch, which 
is the sum of the other next/* branches in arm-soc.

My understanding is that the other branches in Russell's tree are stable in
the sense that they are never rebased, though it might happen that the entire
branch does not get submitted if a problem gets found with the series. That of
course implies that all other dependent trees cannot get submitted.

	Arnd
