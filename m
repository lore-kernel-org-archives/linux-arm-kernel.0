From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 08:33:48 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Koelsch Board Removal Updates
 for v3.19
In-Reply-To: <20141120004003.GB5065@verge.net.au>
References: <cover.1415059146.git.horms+renesas@verge.net.au>
 <201411192306.43386.arnd@arndb.de> <20141120004003.GB5065@verge.net.au>
Message-ID: <236694577.ualUuEDmHa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 09:40:03 Simon Horman wrote:
> On Wed, Nov 19, 2014 at 11:06:43PM +0100, Arnd Bergmann wrote:
> > On Tuesday 04 November 2014, Simon Horman wrote:

> > > ----------------------------------------------------------------
> > > Renesas ARM Based SoC Koelsch Board Removal Updates for v3.19
> > > 
> > > * Remove lecacy C koelsh board support
> > 
> > I've tried merging this one in two ways, but I'm not too happy about either one:
> > 
> > - we could put it into next/boards, but I don't think there will be anything
> >   else in that branch and I was considering not to have one at all.
> > 
> > - it would also fit into next/cleanup, but then we already have
> >   renesas-dt-cleanups-for-v3.19 categorized as "next/dt" rather than
> >   "next/cleanup". Moving that one into cleanups solves the problem
> >   nicely, but it's rather large and my feeling is that Olof's decision
> >   to put it into next/dt was better.
> 
> My assumption was that it is reasonable to base something on a cleanup
> and that as the other base for this is next/dt the this pull request
> would also end up in next/dt.

Correct in principle. Sometimes however we decide to put things into
a different branch than what you had planned, and this is what happened
here when Olof put the dt-cleanup into next/dt, which we normally do
for pull requests that only touch the dts files.

> > I think you are trying too hard to avoid merge conflicts, as I can't see any
> > true dependency on renesas-dt-cleanups-for-v3.19, and I'd be happier if
> > you could rebase it onto renesas-dt-du-for-v3.19 by itself. There is
> > a trivial merge conflict that I have to resolve, but it seems more
> > sensible that way.
> > 
> > Any other thoughts?
> 
> Unfortunately its not quite so simple. The patch
> 
> "ARM: shmobile: koelsch dts: Drop console= bootargs parameter"
> in renesas-koelsch-board-removal-for-v3.19 depends on 
> "ARM: shmobile: kzm9g-reference dts: Add chosen/stdout-path"
> which is on renesas-dt-cleanups-for-v3.19.
> 
> Perhaps it would be better if the latter had not been classified as a
> cleanup. On that topic I must say that I find splitting out
> some patches as cleanups to not be a very useful classification for me.
> 
> A possibility would be to duplicate "ARM: shmobile: kzm9g-reference dts:
> Add chosen/stdout-path" in a revised renesas-koelsch-board-removal-for-v3.19.
> I believe that would leave us with only a trivial conflict in
> arch/arm/boot/dts/Makefile.

Thanks for the explanation. I think the best way forward is to just
classify both renesas-dt-cleanups-for-v3.19 and renesas-koelsch-board-removal-for-v3.19
as cleanups then, which I've done. The dt-cleanup is now in both
next/cleanup and next/dt, while dt-cleanup2 and dt-cleanup3 remain
just in next/dt.

	Arnd
