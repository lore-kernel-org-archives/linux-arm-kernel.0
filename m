From: lethal@linux-sh.org (Paul Mundt)
Date: Mon, 1 Mar 2010 19:11:40 +0900
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <20100301094820.GA10863@n2100.arm.linux.org.uk>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
	<f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
	<20100228161449.GD16745@n2100.arm.linux.org.uk>
	<20100301093927.GC29952@pengutronix.de>
	<20100301094820.GA10863@n2100.arm.linux.org.uk>
Message-ID: <20100301101140.GA12088@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 01, 2010 at 09:48:21AM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 01, 2010 at 10:39:27AM +0100, Uwe Kleine-K?nig wrote:
> > In my eyes there are three different possibilities for the future:
> > 
> >  a) every tree requested for pulling has to keep constant.
> >  b) rmk treats the submaintainer trees as his topic branches that are
> >     regularly merged into devel.
> >  c) Linus pulls directly from submaintainers.
> > 
> > I think c) isn't nice (and AFAIK Linus would request a)).
> > 
> > I'd prefer a).  And if a submaintainer "doesn't behave" next time either
> > both trees are pulled making the arm tree as ugly as are the others
> > sometimes or the second pull request is declined if Russell notes it
> > early enough (maybe supported by some script work).
> 
> I've added Linus to this, so he's aware of what's going on, since if
> I do merge Eric's latest tree, Linus will see duplicate commits from
> me and I don't wish to have one of Linus' responses to that. ;)
> 
> The general rule is that once you've asked someone to pull your tree,
> that's it, the commits are cast in stone.  It doesn't matter who you
> ask to pull your tree.

Out of the non-PXA merge requests, the only conflicts seem to be on
Kconfig/Makefile bits as usual, being fairly insular beyond that. While
these are fairly easy to sort out, it's a bit impolite to jump to c) as
long as other changes in the same area are already present in the ARM
tree. I intentionally did not send my pull request to Linus initially
because I didn't want to create extra work for others merging out of
order and triggering conflicts on the same files. (Although in -next at
the moment I believe it's only 3 trees that are in conflict with regards
to arch/arm/{Kconfig,Makefile}).

c) works so long as there is no overlap between trees and people
generally behave responsibly. Some of the ARM trees already do this
today, where areas of overlap are handled through the ARM tree while
isolated changes are often just pulled directly. As long as people can
determine when to use which strategy then this model works fairly well.
Some merge conflicts will occur regardless, though.

Having said that, many of the ARM architecture git trees are pulled in to
-next directly with merge resolution handled there, some of which will be
merged in to the main ARM tree and others which will not. Anything
showing up in -next should have already been reviewed and aimed at
heading in to Linus's tree directly, so having an extra layer where
everything has to be integrated before being sent out just seems like
extra work. Someone is going to have to do the merge resolution
regardless, the issue is just trying to make sure that the more serious
ones are resolved in the ARM tree.

One way around this would be to have people pull before doing a merge
request, but that also means that you're then sending out a merge request
for something that hasn't seen the testing that the original one did, and
may suddenly have bugs introduced by upstream changes. This isn't an
ideal solution either.
