From: joe@perches.com (Joe Perches)
Date: Tue, 26 Jan 2010 09:10:17 -0800
Subject: whoever is using ymiao3@marvell.com please stop it
In-Reply-To: <20100126113534.GF20792@pengutronix.de>
References: <20100125014024.GA4609@trinity.fluff.org>
	<f17812d71001251730p4747199bhd4176d5835073b56@mail.gmail.com>
	<20100126052317.GY10014@trinity.fluff.org>
	<20100126113534.GF20792@pengutronix.de>
Message-ID: <1264525817.30778.139.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-26 at 12:35 +0100, Uwe Kleine-K?nig wrote:
> On Tue, Jan 26, 2010 at 05:23:18AM +0000, Ben Dooks wrote:
> > On Tue, Jan 26, 2010 at 09:30:39AM +0800, Eric Miao wrote:
> > > That's mine original email, and is invalid now. Everyone please stop using it.
> I already run into that several times as I frequently use
> scripts/get_maintainer.pl.  IMHO we need a mechanism to deprecate email
> addresses, preferably using .mailmap as data source.

As is, I think it's not much of a problem.
People move around and email addresses become invalid.

Over short periods of time, these problems are resolved
without effort or intervention.

scripts/get_maintainer.pl uses first MAINTAINERS patterns
and maintainer name/address, then git history.  The most
recent git name/address combination is used and multiple
address are ignored by default.

If multiple people with identical names are contributing,
a flag --noremove-duplicates exists to stop name/address
merging.

http://lkml.org/lkml/2009/8/5/518

> I'd suggest to check if the address is listed in .mailmap and use the
> first entry for that person.  This would need some work to adapt
> .mailmap, as .mailmap mainly collects wrong entries.

Make sure you adapt git as well.

One thing you could do would be to update
scripts/get_maintainer.pl to scan all MAINTAINERS sections
for a matching name and use that address if it differs from
git log history.

That could update the case where the person has a MAINTAINERS
entry, is not a listed maintainer for a particular file and
had last submitted patches for that file using an old/invalid
address.

I will not be submitting such a patch.
