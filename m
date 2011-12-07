From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Dec 2011 20:10:21 +0000
Subject: [GIT PULL] Linux support for ARM LPAE
In-Reply-To: <20111207112320.GB23720@arm.com>
References: <20111202182054.GA3250@arm.com>
 <20111206124109.GT14542@n2100.arm.linux.org.uk>
 <20111206140729.GA31720@arm.com>
 <20111206233058.GZ14542@n2100.arm.linux.org.uk>
 <20111207112320.GB23720@arm.com>
Message-ID: <20111207201021.GD14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 11:23:20AM +0000, Catalin Marinas wrote:
> On Tue, Dec 06, 2011 at 11:30:58PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Dec 06, 2011 at 02:07:29PM +0000, Catalin Marinas wrote:
> > > This patch wasn't
> > > originally part of my LPAE series as I hoped you would have merged it
> > > during the last cycle. Now it had to be part of the pull request as LPAE
> > > patches depend on it.
> > 
> > I've stated many times why it's not merged, and for the N'th time: it
> > generates warnings.  I'm _not_ merging something that is known to add
> > warnings such as those which this patch produces without there being a
> > fix for it.  You know that _very well_ because I've said it several
> > times, not only by email but also on our various phone calls.
> > 
> > I've dealt with this patch in exactly the same way at every merge window
> > we've had for the last _year_ - I've queued it up with the expectation
> > that hopefully someone would fix the warnings, the warnings didn't get
> > fixed, so it got dropped from the pull request.  Immediately after the
> > merge window (which includes this) it gets reinstated back into
> > linux-next.
> 
> Yes, I'm fully aware, and I sent you a fix-up in the past. I can
> re-write that fix-up in a few other ways if you don't like the current
> one, just let me know.

So you mean you're submitting me my patch that I've been avoiding merging
into mainline _without_ the fixup patch?  It seems not - you do have it
in your pull request:

	ARM: pgtable: Fix compiler warning in ioremap.c introduced by nopud

So what's the issue?  Why do you want to rewrite it yet again?

My guess is that you haven't actually READ what I said above (which is
quoted).  And what is quoted above is _me_ explaining _why_ I have not
merged my own patch and why _I_ _consider_ _the_ _patch_ _as_ _it_
_stands_ _to_ _not_ _be_ _immediately_ _suitable_ _for_ _merging_
___on___ ___its___ ___own___.

The fact is, with the "fix" patch, it _does_ become suitable for merging.

Are you getting the message yet?

Provided you've fixed the sign-off (which you say you have) the only
remaining problem is the conflict between your tree and Will's tree
which you actually require for LPAE to be buildable.  Which, I'll point
out, I'm not looking at at the moment because I'm writing this email to
you this evening instead.
