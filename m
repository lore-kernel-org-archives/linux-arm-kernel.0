From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 23:30:58 +0000
Subject: [GIT PULL] Linux support for ARM LPAE
In-Reply-To: <20111206140729.GA31720@arm.com>
References: <20111202182054.GA3250@arm.com>
 <20111206124109.GT14542@n2100.arm.linux.org.uk>
 <20111206140729.GA31720@arm.com>
Message-ID: <20111206233058.GZ14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 02:07:29PM +0000, Catalin Marinas wrote:
> On Tue, Dec 06, 2011 at 12:41:09PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Dec 02, 2011 at 06:20:54PM +0000, Catalin Marinas wrote:
> > > If there are no further comments, could you please pull the ARM LPAE
> > > branch below? They should be merged after Will's idmap patches (no real
> > > conflict, just correctly functioning setup_mm_for_reboot).
> > 
> > Err, your tree contains a serious error.
> 
> I would say minor error but I agree, it needs fixing.

The DCO is a viewed by many as having legal implications.  Not doing
it means - in this case - that you do not believe you have the right
to pass the change on.  In that case, I can't accept it from you.

If you don't understand that, please, go read Documentation/SubmittingPatches
to learn about when you are required to sign off on patches before
committing them.

> This patch wasn't
> originally part of my LPAE series as I hoped you would have merged it
> during the last cycle. Now it had to be part of the pull request as LPAE
> patches depend on it.

I've stated many times why it's not merged, and for the N'th time: it
generates warnings.  I'm _not_ merging something that is known to add
warnings such as those which this patch produces without there being a
fix for it.  You know that _very well_ because I've said it several
times, not only by email but also on our various phone calls.

I've dealt with this patch in exactly the same way at every merge window
we've had for the last _year_ - I've queued it up with the expectation
that hopefully someone would fix the warnings, the warnings didn't get
fixed, so it got dropped from the pull request.  Immediately after the
merge window (which includes this) it gets reinstated back into
linux-next.

> P.S. I say it's minor because it has the committer information. If you
>      would pull someone else's branch which results in a fast-forward,
>      you can't really tell whether it was a merge or cherry-pick, so the
>      rule is not entirely consistent (unless you also mandate --no-ff
>      for merges).

That is a known and accepted "limitation" - as is the "limitation" that
you can't add the sign-off to each commit you've pulled in.  What Linus
really wants is stuff to be tracked to the point it enters into git via
sign-offs.  From then on, the accountability trail follows the merge
commits.
