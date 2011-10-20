From: david@fromorbit.com (Dave Chinner)
Date: Fri, 21 Oct 2011 09:21:09 +1100
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <4E9F5F1B.1020106@am.sony.com>
References: <4E9E0B71.9020708@am.sony.com>
	<20111019073547.GR21648@n2100.arm.linux.org.uk>
	<4E9F5F1B.1020106@am.sony.com>
Message-ID: <20111020222109.GB14993@dastard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2011 at 04:36:59PM -0700, Tim Bird wrote:
> On 10/19/2011 12:35 AM, Russell King - ARM Linux wrote:
> > On Tue, Oct 18, 2011 at 04:27:45PM -0700, Tim Bird wrote:
> >> I'm about to submit a set of patches (really pretty small)
> >> to add 4K stack support to ARM (defaulted to 'N').
> >>
> >> This has been kicking around in my Sony tree for a few years,
> >> and it's about time to mainline it.  The first patch is
> >> the actual 4KSTACKS patch.  See subsequent patches
> >> for tools to help with stack reduction to avoid the problems
> >> that apparently led to the removal of this feature on x86.
> > 
> > This isn't a good idea - if the feature has been abandoned on x86,
> > people aren't going to be soo concerned about the stack usage of
> > each function.  They're going to accept that there's more stack
> > space available, and we'll see code paths that start expecting that.
> 
> Well, the difference in size is not an order of magnitude.  Current
> stacks are only twice as big as what this feature optionally allows.
> So people really shouldn't go crazy with their stack usage.
> 
> Granted we're already seeing a bit of stack bloat, but IMHO this should
> be nipped in the bud.  If the stack grows a lot more, it will likely
> need to shift to 16K, which would REALLY be costly on machines
> with lots of threads and low memory.

FWIW, I was seriously considering bringing up 16k stacks on x86-64
as a topic for the kernel summit. We've been getting reports of the
8k stack being blown on different filesystems for the past year or
so on relatively trivial storage configs....

Cheers,

Dave.
-- 
Dave Chinner
david at fromorbit.com
