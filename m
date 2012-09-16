From: gerg@snapgear.com (Greg Ungerer)
Date: Sun, 16 Sep 2012 10:15:35 +1000
Subject: [PATCH] clk: Make the managed clk functions generically available
In-Reply-To: <20120915213151.GM12245@n2100.arm.linux.org.uk>
References: <1347202862-1617-1-git-send-email-lars@metafoo.de>
 <20120909235059.GA2643@sirena.org.uk>
 <20120910001524.GL13739@n2100.arm.linux.org.uk>
 <20120910002020.GB16249@opensource.wolfsonmicro.com>
 <20120910003913.GM13739@n2100.arm.linux.org.uk> <504F4E36.20309@metafoo.de>
 <1347375033.27206.3.camel@sauron.fi.intel.com>
 <504FE633.2090304@snapgear.com> <5050F3DB.1050202@metafoo.de>
 <20120915213151.GM12245@n2100.arm.linux.org.uk>
Message-ID: <50551A27.5070807@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2012 07:31 AM, Russell King - ARM Linux wrote:
> On Wed, Sep 12, 2012 at 10:43:07PM +0200, Lars-Peter Clausen wrote:
>> I wouldn't mind having this merged sooner rather than later, there is at least
>> one driver in next which is currently broken due to the missing devm_clk_get.
>> Russell what's your plan for the patch? Maybe under the given circumstances it
>> makes sense to let it go through the m68k tree.
>
> Ok, I've merged it but there was no indication in the patch that it was
> supposed to be a fix... there's no cc: to stable.  Does it need to go to
> stable?  When was this brokenness introduced?  What's the story for the
> m68k bit?

For the m68k issues this is not a candidate for stable. The breakage
that this fixes did not occur until the 3.6 merge window.

The fact that it fixes some breakage on some m68k platforms is more
of a side effect, and the original patch author would not have known
about this. The underlying problem was with the local m68k/coldfire
implementation of devm_clk_get, but this patch makes that code go
away completely.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
