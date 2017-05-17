From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 17 May 2017 14:46:02 -0700
Subject: [PATCH v2 00/18] ARM64: meson: DT cleanups
In-Reply-To: <20170513143337.14278-1-afaerber@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?=
 message of "Sat, 13 May 2017 16:33:19 +0200")
References: <20170513143337.14278-1-afaerber@suse.de>
Message-ID: <m2mvab88dh.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

Andreas F?rber <afaerber@suse.de> writes:

> This series fixes several cosmetic issues, on top of your for-next branch.
>
> Patches 3-6 rename a node, the rest should all be non-functional changes.
>
> PLEASE STOP merging random new nodes at the bottom of DT files!
> Just like it's a convention to sort new nodes by unit address, it has been
> a convention to sort by-label nodes by their label. As discussed here and
> elsewhere, this helps avoid merge conflicts and makes nodes easy to find.
> I don't care whether we order A0 before A or after, but adding new HDMI
> or CVBS nodes at the very bottom is totally out of alphabetical order.
> Since my v1 you really should've known that...

Your tone is a bit tiresome and frankly makes me hesitate before
reviewing the patches.  If you expect cordial dialogue and producitve
collaboration, please dial the accusations back a notch.

[ ... deep breath ... ]

Yes, your point was clear in v1, but that doesn't mean I agreed with it,
or that I particularily pay attention to that in my reviews because
honestly, alphabetical sorting is not very high on the list of things I
care about.  Over many years of being a kernel maintainer, I've had to
deal with my share of headaches, but conflicts caused by poorly sorted
DT files hs never been on my list of pain points.

That being said, I understand your concerns and similar ones raised
maintainers on other platforms.  I'm not a big fan of the churn caused
by this kind of rework, *but* I'm also not opposed to keeping things
better organized.  So, since there is an active contributor (and
reviewer) that is willing to put in the time and effort to clean things
up, I don't see a good (enough) reason to say no.

So, I will apply the series as is to my v4.13/dt64 branch

Going forward, I will try to keep an eye on the organization of DTS
files, but honestly, it's low priority for me, so if this is something
you care about, I trust that you will continue to help review DTS files.

I know you're already doing many reviews along with your contributions,
so thanks for that, and please keep it up. :)

> Similarly, Khadas Vim shouldn't have been merged with the "bcrmf" typo.
>
> Which proves my point that we need to fix these issues now so that they
> don't keep spreading (Broken Window Theory). New boards have not been
> checked for sort order, only boards already touched in v1.
>
> Board and Makefile order affect my pending R-Box Pro patches.
> Node order affects Martin's pending Bluetooth patches among others.

Yes, this series will affect a few other series that are in flight, and
I apologize to those developers for the needed rebase, but I'd rather
apply a series like this that affects so many DT files early in the
cycle.

Thanks again for the fixes and cleanups,

Kevin
