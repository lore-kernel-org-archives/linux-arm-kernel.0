From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Aug 2011 23:23:22 +0200
Subject: Patch Merging Path - RMK or Arnd?
In-Reply-To: <20110819144551.GI8918@e102144-lin.cambridge.arm.com>
References: <20110819124933.GG8918@e102144-lin.cambridge.arm.com>
	<201108191621.56263.arnd@arndb.de>
	<20110819144551.GI8918@e102144-lin.cambridge.arm.com>
Message-ID: <6572911.Q9nnzRlLsr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 August 2011 15:45:51 Will Deacon wrote:
> > Fortunately, git can handle merges of that sort just fine, so I'd say
> > depending on the contents you do one of:
> > 
> > (4) Split up the changesets into a core set (for the arch directory) and
> >     a second set that goes on top and changes all the platforms. Get
> >     Russell to take the base patches into one branch, and submit the
> >     branch containing the full set (including the ones in Russell's
> >     tree) for the arm-soc tree. I will then make sure queue the changes
> >     for merging to Linus after he has taken the base changes from
> >     Russell.
> > 
> > (5) Prepare one git tree and submit it to both trees at once. If everyone
> >     is happy with the changes, we just apply it to both and one of us
> >     submits it first.
> >     Either tree can also contain further changes on top, so if your
> >     changes are already upstream through one tree, the second pull request
> >     from the other tree will contain the other changes that go on top.
> 
> That's (5) probably easiest, because then you can be sure that the patches
> in each upstream tree are identical.

That's the idea with (4) as well. The difference there is that one of the
two trees only contains a subset of the patches, but those are using the
same commit IDs. The other tree has the remaining changes on top of the
common ones.

	Arnd
