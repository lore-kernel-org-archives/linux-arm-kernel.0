From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 1 Mar 2010 08:40:26 -0800 (PST)
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <20100301094820.GA10863@n2100.arm.linux.org.uk>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
	<f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
	<20100228161449.GD16745@n2100.arm.linux.org.uk>
	<20100301093927.GC29952@pengutronix.de>
	<20100301094820.GA10863@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1003010827330.3616@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 1 Mar 2010, Russell King - ARM Linux wrote:
> On Mon, Mar 01, 2010 at 10:39:27AM +0100, Uwe Kleine-K?nig wrote:
> >
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

Yes. I think (a) is the right thing to do, ie if rmk is pulling from 
others, then those others must always follow the same rules that _I_ 
require people I pull from to follow.

Quite frankly, (b) is going to be a total mess. It's been done. The 
resulting 'devel' branch will end up looking like 'next', and while 
there's no question that 'next' isn't very useful, it's also almost 
totally impossible to look through the history of it when things go wrong 
(git has 'rerere' to remember previous merge resolutions so that they 
don't have to be re-done over and over again, but that's about the only 
kind of "history of history" that git helps with).

And while (c) is something I do, it's something I want to do 
_occasionally_ rather than all the time. IOW, I'll happily take direct 
pulls from submaintainers, but I'd rather have a good reason for it (ie 
maintainer is temporarily busy with something else, or it's an urgent fix 
late in the -rc series that somebody just wants to happen asap etc).

So I'd much prefer (a). And that does mean that submaintainers have to be 
more on-the-ball.

IOW, if a submaintainer ask somebody else to pull from them, that tree is 
now public, and cannot then be rebased or do other history-destroying 
things.

This obviously does require that submaintainers be more careful, but 
that's a _good_ thing. They need to think twice before asking their 
higher-up maintainer to pull their stuff, because once it's pulled, it's 
set in stone.

rmk: I think it's ok if you end up having to rebase something this time in 
order to fix up a mistake that has already happened - no rule should be 
_so_ set in stone that it can't be violated when bad things happen.

But you could be hard-nosed and push the pain downward (that's what I tend 
to try to do), ie do something like force your submaintainers to go back 
to the old state that you already pulled from, and then rebase their 
subsequent changes on top of that.

The reason _I_ tend to push the pain back down is (a) I'm lazy, and I damn 
well like it that way and (b) I also happen to think that it's 
fundamentally much better to "spread out" the pain as widely as possible 
than have it concentrate at some maintainer level.

So not only for me personally, but in general, I think it's better if we 
strive to push the burden of maintenance as far out as possible. That way 
the development model scales, rather than become too tied up with 
particular maintainers having to be really really on top of everything.

				Linus
