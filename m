From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 May 2010 17:18:20 +0100
Subject: RMK closing tree to patches *this* weekend
In-Reply-To: <000301caf5d7$d15bab60$74130220$@deacon@arm.com>
References: <20100513230201.GA26822@n2100.arm.linux.org.uk>
	<20100517090310.GE23118@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1005170858290.12758@xanadu.home>
	<20100517151036.GE29422@n2100.arm.linux.org.uk>
	<000301caf5d7$d15bab60$74130220$@deacon@arm.com>
Message-ID: <20100517161820.GA9304@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 04:44:20PM +0100, Will Deacon wrote:
> Hi Russell,
> 
> > Therefore, this "initial batch" is most likely to become "only batch"
> > since it's no longer possible to be reasonably ensure that there will
> > be a merge window open in the second week.
> 
> If this is likely to be the case, will the OProfile patches be merged
> during this batch? The reason I ask is because they have been applied to
> the `devel-pmu' branch, but I can't find this in your repository. I also
> can't see the patches in any of your other branches.
> 
> Knowing when the Kernel patches will be going in helps me to co-ordinate
> submission of the accompanying userspace patches.

As I've already pointed out:

http://lists.arm.linux.org.uk/lurker/message/20100516.144933.63587837.en.html

As I've said repeatedly over the last few weeks, there's three patch
"series" which depend on lots of other stuff in the tree, and merging
it out of order will result in build breakage or stuff being missed.
These are:

1. Hartley's removal of 'select GENERIC_GPIO'
2. Your PMU patches
3. John Stultz removal of 'select GENERIC_TIME'

I'm waiting for (1) at the moment, then I'll re-merge (2) and devel-stable,
and then I can ask John to redo his patch - which will depend on
everything in my tree - it will touch stuff which only exists in both
the existing 'devel' and 'devel-stable' branches.

This is why I really wanted to close my tree a week before the merge
window - to give a reasonable time to get these patches sorted out and
properly tested.  We don't have that choice now - instead, what we have
is a panic to get this all sorted.  So we'll all do the testing of the
result after it's in Linus tree.

Now, should Hartley for whatever reason not be able to sort his patch out
by tomorrow morning (my time), I shall be taking the view that the patch
is not important, and we can play this lottery again for the following
merge window...
