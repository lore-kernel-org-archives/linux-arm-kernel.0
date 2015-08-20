From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 21 Aug 2015 01:58:19 +0200
Subject: [GIT PULL] at91: defconfig for 4.3 #2
In-Reply-To: <CAOesGMhwAYUAMLyT6TH38-0VmZNLEpcd_=Tq=EF1KJ=eywBmUw@mail.gmail.com>
References: <20150807162754.GA20169@piout.net>
 <20150813100938.GN30160@localhost>
 <20150813112118.GA22269@piout.net>
 <20150813122643.GA23581@localhost>
 <20150814092237.3551c03e@canb.auug.org.au>
 <CAOesGMhwAYUAMLyT6TH38-0VmZNLEpcd_=Tq=EF1KJ=eywBmUw@mail.gmail.com>
Message-ID: <20150820235819.GH3769@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18/08/2015 at 23:49:30 +0200, Olof Johansson wrote :
> > The only thing now is that since the at91 tree is in linux-next as well
> > as the arm-soc tree, those patches appear twice there and there is a
> > conflict (easy to fix, but a pain).  The solution here is to update the
> > at91 tree to be somewhere in the arm-soc tree (probably just reset to
> > the point where the two trees match in patches but not commits).  This
> > has the downside that the at91 tree will be rebased which will affect
> > any development work that is based on that.
> >
> > If there was just one patch in common, it maybe have been better to
> > just merge the at91 tree and fix the conflict in the merge.
> 
> Yeah, this is a somewhat frustrating situation for us. I wonder if we
> should essentially tag the downstream ARM platform trees in -next such
> that if they conflict with arm-soc, you can drop them for a day if
> needed.
> 
> It's really useful for us to be able to occasionally adjust a pull
> request instead of always merging them exactly as they're presented to
> us. It saves a roundtrip to the maintainer for trivial stuff, we can
> take care of it and not have to look at it again. We often do send it
> back to the maintainers to respin, but in this particular case it
> seemed appropriate to just deal with it locally for us.
> 
> The downstream users vs rebasing git trees is of course another
> aspect. Here I'm mostly relying on subplatform maintainers to know
> well how many people actually develop on top of their trees. I think
> for most platforms it's a fairly limited use. Interesting enough, I
> can't remember last time someone told me they couldn't respin a pull
> request to fix something up due to downstream developers (not that we
> have _all_ that many of those requests).
> 

I think there is no issue to rebase at91-next apart from Nicolas being
on holiday and the fact that I don't have access to it.

> The other way to handle this would be to only apply patches directly
> and not do merges. Most other high-volume maintainers have exactly
> this workflow. We've been able to avoid reverting to that, thankfully
> (since we can delegate most of the reviews and patch applications this
> way).
> 

On an other topic but not completely unrelated, I see that you are
adding your SoB only on merge commits so basically, when the merge is a
fast forward, your SoB doesn't appear at all.
For now, I've chosen to apply PRs as patches to add my SoB, is that
something I can avoid?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
