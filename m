From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 30 Nov 2009 19:09:50 +0000
Subject: cache aliasing in dup_mmap
In-Reply-To: <20091130092022.GA1638@n2100.arm.linux.org.uk>
References: <20091005144623.GA20633@n2100.arm.linux.org.uk>
	<20091105144830.GC21681@n2100.arm.linux.org.uk>
	<e06498070911130649k2051e4cfh2066cf0b9fdabbaf@mail.gmail.com>
	<20091116163028.GA3568@n2100.arm.linux.org.uk>
	<e06498070911160923i2273b6aai6f144b36289203d2@mail.gmail.com>
	<20091116222016.GF3568@n2100.arm.linux.org.uk>
	<20091119085735.GA14178@n2100.arm.linux.org.uk>
	<e06498070911191008t1861e730u5cdb49187af00ae0@mail.gmail.com>
	<20091123203110.GH18142@n2100.arm.linux.org.uk>
	<20091130092022.GA1638@n2100.arm.linux.org.uk>
Message-ID: <20091130190950.GB5560@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Nov 23, 2009 at 08:31:10PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Nov 19, 2009 at 01:08:01PM -0500, Steven Walter wrote:
> > > On Thu, Nov 19, 2009 at 3:57 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > I'm afraid that I have nothing further to suggest, and so I'm shelving
> > > > the patches. ?That means this problem will remain unresolved in future
> > > > kernels.
> > > 
> > > I had the tester restart the reboot-loop, and so far it's done ~1200
> > > runs with no problem.  I'm thinking now that either I hosed something
> > > up with the build initially, or else the tester didn't flash it
> > > correctly.  1200 runs isn't enough to be conclusive, but it's a lot
> > > better than 88.  I'll let you know when we have something more
> > > definitive.
> > 
> > I'd just like to keep this issue hot so it doesn't get forgotten about.
> > Are we at a conclusive point on this?
> 
> Today is decision day.  Do we go with these two patches or not?

Way back when this thread started, I had a think about the proposed
fix and thought it was insufficient in some cases.  That is, the race
could still occur but not as often.  But it was hard to explain, and I
don't think I did so adequately.

The patches are an improvement.  That's a good enough reason to apply
them, but I'm grateful this thread keeps popping to the top of my
inbox to remind me to have a think about the corner cases again,
because I suspect the issue is not fully closed.

-- Jamie
