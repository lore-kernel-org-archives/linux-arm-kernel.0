From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Mar 2018 14:26:34 +0000
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <20180305130859.GB17802@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <20180305124638.GG8588@sirena.org.uk>
 <20180305130859.GB17802@kroah.com>
Message-ID: <20180306142634.GC13586@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 02:08:59PM +0100, Greg KH wrote:

> I know there is lots more than Android to ARM, but the huge majority by
> quantity is Android.

> What I'm saying here is look at all of the backports that were required
> to get this working in the android tree.  It was non-trivial by a long
> shot, and based on that work, this series feels really "small" and I'm
> really worried that it's not really working or solving the problem here.

Unfortunately what's been coming over was just the bit about using
android-common, not the bit about why you're worried about the code.  :(

> There are major features that were backported to the android trees for
> ARM that the upstream features for Spectre and Meltdown built on top of
> to get their solution.  To not backport all of that is a huge risk,
> right?

I'm not far enough into the details to comment on the specifics here;
there's other people in the CCs who are.  Let's let people look at the
code and see if they think some of the fixes are useful in LTS.  The
Android tree does have things beyond what's in LTS and there's been more
time for analysis since the changes were made there.

> So that's why I keep pointing people at the android trees.  Look at what
> they did there.  There's nothing stoping anyone who is really insistant
> on staying on these old kernel versions from pulling from those branches
> to get these bugfixes in a known stable, and tested, implementation.

I think there's enough stuff going on in the Android tree to make that
unpalatable for a good segment of users.

> Or just move to 4.14.y.  Seriously, that's probably the safest thing in
> the long run for anyone here.  And when you realize you can't do that,
> go yell at your SoC for forcing you into the nightmare that they conned
> you into by their 3+ million lines added to their kernel tree.  You were
> always living on borowed time, and it looks like that time is finally
> up...

Yes, there are some people who are stuck with enormous out of tree patch
sets on most architectures (just look at the enterprise distros!) - but
there are also people who are at or very close to vanilla and just
trying to control their validation costs by not changing too much when
they don't need to.  There's a good discussion to be had about it being
sensible for people to accept more change in that segment of the market
but equally those same attitudes have been an important part of the
pressure that's been placed on vendors long term to get things in
mainline.  

> [1] It's also why I keep doing the LTS merges into the android-common
>     trees within days of the upstream LTS release (today being an
>     exception).  That way once you do a pull/merge, you can just keep
>     always merging to keep a secure device that is always up to date
>     with the latest LTS releases in a simple way.  How much easier can I
>     make it for the ARM ecosystem here, really?

That's great for the Android ecosystem, it's fantastic work and is doing
a lot to overcome resistances people had there to merging up the LTS
which is going to help many people.  While that's a very large part of
ARM ecosystem it's not all of it, there are also chip vendors and system
integrators who have made deliberate choices to minimize out of tree
code just as we've been encouraging them to.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180306/964dec19/attachment.sig>
