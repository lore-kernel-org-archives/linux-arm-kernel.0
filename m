From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 May 2010 19:15:43 +0100
Subject: MSM PMU Support in Commit ee3c454b
In-Reply-To: <000101caee07$104acdc0$30e06940$@deacon@arm.com>
References: <000101caee07$104acdc0$30e06940$@deacon@arm.com>
Message-ID: <20100507181543.GC7887@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 07, 2010 at 06:02:23PM +0100, Will Deacon wrote:
> I can update the patch in the patch system so it applies cleanly, but
> the mach-msm bsp will need updating to register the IRQ using the new
> mechanism. Daniel: would you like me to submit a patch to do this, or
> would you rather do it [since I'm unfamiliar with the mach]?

This is going to be horrible...  I maintain a completely separate branch
for pulling git trees into from the (multiple) branches which have the
patches in.

Fixing this will tie all the branches together, which I do not want to
do at the moment.

My intention is as follows:

1. Freeze the multiple branches with patches next week.
2. Apply your patches on top of the merged-set of those branches.
3. Apply the other pending patches which are dependent on these branches.

Now, at that point, the devel-stable branch won't merge cleanly back
into devel because of this MSM problem, and the problem is how do we
solve that.

It's not trivial, because you can't just add the platform device - it's
dependent on your patch in my tree adding the enum.

Maybe I'll just keep the devel-stable branch entirely separate until
the devel stuff has been merged, and then MSM can be sorted at some
point later.  This unfortunately means that devel-stable drops out of
linux-next.  It also means that linux-next is at risk of missing the
merge window... again.
