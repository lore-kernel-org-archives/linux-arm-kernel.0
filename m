From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Aug 2011 15:45:51 +0100
Subject: Patch Merging Path - RMK or Arnd?
In-Reply-To: <201108191621.56263.arnd@arndb.de>
References: <20110819124933.GG8918@e102144-lin.cambridge.arm.com>
	<201108191621.56263.arnd@arndb.de>
Message-ID: <20110819144551.GI8918@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for the reply.

On Fri, Aug 19, 2011 at 03:21:56PM +0100, Arnd Bergmann wrote:
> On Friday 19 August 2011, Will Deacon wrote:
> > Ideally, I would also merge these via Russell, but there is now scope for
> > conflict with your arm-soc branch given that I'm changing files under mach-*
> > and plat-*. How would you recommend that I proceed? I can think of three
> > solutions:
> > 
> > 
> > (1) [preferred] Merge via Russell, conflicts show up in -next and are
> >     resolved then.
> > 
> > (2) Split the patches up so that the core changes go via Russell. When they
> >     are in a suitable tree (-next?) then send you the remainder on top of
> >     that.
> > 
> > (3) Merge the whole lot via you. This really just inverts the problem rather
> >     than solving anything.
> > 
> > 
> > I expect this will become a fairly common pattern with single zImage work,
> > so it would be great to clarify the intended path upstream.
> 
> There is another options, which is to have the changes in both trees, or
> at least have some of the changes in both.

Ok, I hadn't considered that.

> Fortunately, git can handle merges of that sort just fine, so I'd say
> depending on the contents you do one of:
> 
> (4) Split up the changesets into a core set (for the arch directory) and
>     a second set that goes on top and changes all the platforms. Get
>     Russell to take the base patches into one branch, and submit the
>     branch containing the full set (including the ones in Russell's
>     tree) for the arm-soc tree. I will then make sure queue the changes
>     for merging to Linus after he has taken the base changes from
>     Russell.
> 
> (5) Prepare one git tree and submit it to both trees at once. If everyone
>     is happy with the changes, we just apply it to both and one of us
>     submits it first.
>     Either tree can also contain further changes on top, so if your
>     changes are already upstream through one tree, the second pull request
>     from the other tree will contain the other changes that go on top.

That's (5) probably easiest, because then you can be sure that the patches
in each upstream tree are identical.

Russell - would you be happy with this arrangment for patchsets that touch
platforms and core ARM code?

Will
