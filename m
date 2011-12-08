From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Dec 2011 00:16:33 +0000
Subject: [GIT PULL] Linux support for ARM LPAE
In-Reply-To: <20111207202912.GE14542@n2100.arm.linux.org.uk>
References: <20111202182054.GA3250@arm.com>
 <20111206124109.GT14542@n2100.arm.linux.org.uk>
 <20111206140729.GA31720@arm.com>
 <20111206233058.GZ14542@n2100.arm.linux.org.uk>
 <20111207112320.GB23720@arm.com> <20111207122544.GD23720@arm.com>
 <20111207202912.GE14542@n2100.arm.linux.org.uk>
Message-ID: <20111208001633.GJ14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 08:29:12PM +0000, Russell King - ARM Linux wrote:
> What I want from you - by 5pm tomorrow so I can get this stuff merged -
> is a pull request for the LPAE stuff as it was in your v2 pull request,
> either based on top of _either_ my devel-stable (if you can get it - as
> the machine is having severe problems running git atm) or with Will's
> idmap changes merged into it _before_ the LPAE changes.

For the avoidance of any doubt - and any argument - the 5pm time limit
is there to bring this debacle to a close in a reasonable period.  It's
purely there because I want to get this merged by end of Thursday and
no later.

To summarise, my objections are quite simply:

1. Your lack of sign-off on my patch which you merged (which you've
   addressed in pull v2.)
2. The combined point of the merge conflict between your tree and Will's
   idmap tree, plus the dependency your tree _does_ have on the idmap
   changes means it _should_ include Will's idmap changes to ensure
   bisectability - and this has the side effect of solving the merge
   conflict which shouldn't be there.

Any other objections which you think I've made are a purely a figment
of your imagination.

Now, one thing I haven't checked is the ordering of the commits -
particularly the ordering of the 'fix' patch and my patch.  Unfortunately,
standard git pull messages don't give the order so it's not something I
can readily check.  I commented on this issue when you posted the patch
set.  I hope it will be correct for pull v3 (iow, the fix patch first,
then my patch.)
