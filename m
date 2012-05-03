From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 May 2012 16:46:09 +0200
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <201205031350.35476.arnd@arndb.de>
References: <201205031350.35476.arnd@arndb.de>
Message-ID: <20120503144609.GK4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 01:50:35PM +0000, Arnd Bergmann wrote:
> Hi everyone,
> 
> I've been discussing multiplatform kernels with a few people recently,
> and we will have a lot of discussion sessions about this at Linaro
> Connect in Hong Kong.
> 
> One question that came up repeatedly is whether we should support all
> possible board files for each platform in a multiplatform kernel,
> or just the ones that are already using DT probing. I would like
> to get a quick poll of opinions on that and I've tried to put those
> people on Cc that would be most impacted by this, i.e. the maintainers
> for platforms that have both DT and non-DT board files at the moment.
> 
> My feeling is that we should just mandate DT booting for multiplatform
> kernels, because it significantly reduces the combinatorial space
> at compile time, avoids a lot of legacy board files that we cannot
> test anyway, reduces the total kernel size and gives an incentive
> for people to move forward to DT with their existing boards.
> 
> The counterargument is that we won't be able to support all the
> boards we currently do when the user switches on multiplatform,
> but I think that is acceptable.
> Note that I would still want to allow users to build platforms
> separately in order to enable the ATAG style board files, even
> for platforms that are not multiplatform capable.
> 
> Other opinions?

I don't think that enforcing DT only in multiplatform kernels will speed
up porting to DT. As a platform maintainer I am interested in building
multiplatform Kernels, but our customers are mostly uninterested in
this. They probably disable other platforms anyway to save the binary space.

So unless there are real technical problems supporting DT and !DT in a
single kernel (and Russells answer seems to say there aren't) I say no
to creating this restriction.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
