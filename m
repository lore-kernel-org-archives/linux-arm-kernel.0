From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Sep 2012 14:02:17 +0100
Subject: [PATCH V3 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <50488DB8.1010007@free-electrons.com>
References: <1346852677-5381-1-git-send-email-gregory.clement@free-electrons.com>
 <1346852677-5381-4-git-send-email-gregory.clement@free-electrons.com>
 <20120906111152.GE858@mudshark.cambridge.arm.com>
 <50488DB8.1010007@free-electrons.com>
Message-ID: <20120906130217.GI858@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 12:49:12PM +0100, Gregory CLEMENT wrote:
> On 09/06/2012 01:11 PM, Will Deacon wrote:
> > On Wed, Sep 05, 2012 at 02:44:34PM +0100, Gregory CLEMENT wrote:
> >> Aurora Cache Controller was designed to be compatible with the ARM L2
> >> Cache Controller. It comes with some difference or improvement such
> >> as:
> >> - no cache id part number available through hardware (need to get it
> >>   by the DT).
> >> - always write through mode available.
> >> - two flavors of the controller outer cache and system cache (meaning
> >>   maintenance operations on L1 are broadcasted to the L2 and L2
> >>   performs the same operation).
> >> - in outer cache mode, the cache maintenance operations are improved and
> >>   can be done on a range inside a page and are not limited to a cache
> >>   line.

[...]

> > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > 
> 
> Thanks. I guess you also reviewed patches 1 and 2, don't you?

Well I didn't really read those because they looked fairly boring :)
Boring is good though, so I doubt they're problematic.

> And then where should I push my series?
> 
> Patches 1,2 and 3 depend of ARM subsystem so they should be submitted
> using Russell King's patch state system. Patches 4 and 5 are more soc
> specific and should go to marvell tree and then arm-soc. But patches 4
> and 5 are meaningless if the first patches are not applied. What is the
> good practice?

When I end up in situations like this, I usually prepare a branch for
Russell containing the patches that should go via his tree. Then, send him a
pull request and once he has pulled it, Arnd and Olof can pull the same
branch into arm-soc as a baseline branch. You can then base your other
patches on top of that.

Make sense?

Will
