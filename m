From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 3 May 2012 15:45:46 +0200
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <201205031350.35476.arnd@arndb.de>
References: <201205031350.35476.arnd@arndb.de>
Message-ID: <20120503134546.GB7788@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:50 Thu 03 May     , Arnd Bergmann wrote:
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
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> The counterargument is that we won't be able to support all the
> boards we currently do when the user switches on multiplatform,
> but I think that is acceptable.
> Note that I would still want to allow users to build platforms
> separately in order to enable the ATAG style board files, even
> for platforms that are not multiplatform capable.

> 
> Other opinions?
it will also avoid us alot of trouble and work to fix old platform that we can
not even test

Best Regards,
J.
