From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Aug 2011 13:49:33 +0100
Subject: Patch Merging Path - RMK or Arnd?
Message-ID: <20110819124933.GG8918@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

In general, I merge my patches via Russell as they tend to be core ARM changes.
This works very well since other (potentially conflicting) changes follow
the same route and any conflicts would be noticed almost immediately.

However, I currently have two patchsets that I'm developing which alter both
core ARM code *and* touch a number of platforms to use the new core
features:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/061304.html

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/061477.html

Ideally, I would also merge these via Russell, but there is now scope for
conflict with your arm-soc branch given that I'm changing files under mach-*
and plat-*. How would you recommend that I proceed? I can think of three
solutions:


(1) [preferred] Merge via Russell, conflicts show up in -next and are
    resolved then.

(2) Split the patches up so that the core changes go via Russell. When they
    are in a suitable tree (-next?) then send you the remainder on top of
    that.

(3) Merge the whole lot via you. This really just inverts the problem rather
    than solving anything.


I expect this will become a fairly common pattern with single zImage work,
so it would be great to clarify the intended path upstream.

Cheers,

Will
