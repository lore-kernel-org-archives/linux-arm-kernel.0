From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 May 2012 16:28:21 +0100
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120502015650.GE17311@gmail.com>
References: <20120426095135.GG17184@pengutronix.de>
 <4F9EE84C.90106@codeaurora.org>
 <CAJOA=zNCagT6GaeHi_jq7-LU9P-SfJZ8PA9bo-oeswjC0tHyYA@mail.gmail.com>
 <4F9F1659.1010804@codeaurora.org>
 <20120501081103.GC2194@S2101-09.ap.freescale.net>
 <20120501091334.GG15541@lunn.ch>
 <20120501170001.GB4089@opensource.wolfsonmicro.com>
 <4FA0258D.8020807@codeaurora.org>
 <20120501181922.GD4089@opensource.wolfsonmicro.com>
 <20120502015650.GE17311@gmail.com>
Message-ID: <20120502152820.GD5722@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 06:56:50PM -0700, Mike Turquette wrote:
> On 20120501-19:19, Mark Brown wrote:

> > To be honest it doesn't look like your patch is a particular issue here
> > - there's wider process problems, for example we've managed to go
> > through most of the release cycle and so far the only changes showing up
> > in -next are:

> I think that "wider process problems" is probably a euphemism, and I'll
> take responsibility for that.  This has been a learning process for me
> and I underestimated the percentage of my time that would be consumed by
> common clk maintenance.  I'm trying to rectify that problem now.

It's not really a euphamism - it really does seem like we've got all the
technical stuff proceeding reasonably well but we're just struggling
with the mechanics of actually getting the code into -next and on its
way to mainline.

> I was happy to push my changes to Linus directly (as discussed in
> previous mails) but I'm starting to think that maybe having Arnd absorb
> the clk-next branch as part of arm-soc would be the fastest way to
> assist platforms that are porting over.

> Do the platform folks agree?  Is this suggestion sane?

Seems to make sense to me; if there's some bits that are less clear you
could always keep them on a branch separate to the one that the
platforms use.  It's probably also worth getting things into -next
directly, that way integration testing of bleeding edge stuff can happen
before it's been merged into other trees and it's hard to change.

What I've tried do with regmap when it's been possible (it's not this
time around because the stride changes touch everything) is to have
topic branches so that people can pull in only the specific bits they
need.  I still end upn sending a pull request to Linus even if chunks of
it have also gone via other trees.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120502/ebe43f4f/attachment.sig>
