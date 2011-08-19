From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Aug 2011 16:21:56 +0200
Subject: Patch Merging Path - RMK or Arnd?
In-Reply-To: <20110819124933.GG8918@e102144-lin.cambridge.arm.com>
References: <20110819124933.GG8918@e102144-lin.cambridge.arm.com>
Message-ID: <201108191621.56263.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 August 2011, Will Deacon wrote:
> Ideally, I would also merge these via Russell, but there is now scope for
> conflict with your arm-soc branch given that I'm changing files under mach-*
> and plat-*. How would you recommend that I proceed? I can think of three
> solutions:
> 
> 
> (1) [preferred] Merge via Russell, conflicts show up in -next and are
>     resolved then.
> 
> (2) Split the patches up so that the core changes go via Russell. When they
>     are in a suitable tree (-next?) then send you the remainder on top of
>     that.
> 
> (3) Merge the whole lot via you. This really just inverts the problem rather
>     than solving anything.
> 
> 
> I expect this will become a fairly common pattern with single zImage work,
> so it would be great to clarify the intended path upstream.

There is another options, which is to have the changes in both trees, or
at least have some of the changes in both.

Fortunately, git can handle merges of that sort just fine, so I'd say
depending on the contents you do one of:

(4) Split up the changesets into a core set (for the arch directory) and
    a second set that goes on top and changes all the platforms. Get
    Russell to take the base patches into one branch, and submit the
    branch containing the full set (including the ones in Russell's
    tree) for the arm-soc tree. I will then make sure queue the changes
    for merging to Linus after he has taken the base changes from
    Russell.

(5) Prepare one git tree and submit it to both trees at once. If everyone
    is happy with the changes, we just apply it to both and one of us
    submits it first.
    Either tree can also contain further changes on top, so if your
    changes are already upstream through one tree, the second pull request
    from the other tree will contain the other changes that go on top.

This is really not much different to dependencies on any other tree,
e.g. when the gpio subsystem has some changes that are required for
platform specific changes that go through the arm-soc tree.

	Arnd
