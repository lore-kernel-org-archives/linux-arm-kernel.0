From: gerg@snapgear.com (Greg Ungerer)
Date: Tue, 5 Jun 2012 16:55:23 +1000
Subject: Freescale fec.c driver breakage
In-Reply-To: <20120604091616.GA3943@opensource.wolfsonmicro.com>
References: <4FCC3CB4.5030107@snapgear.com>
 <20120604081937.GH30400@pengutronix.de>
 <20120604091616.GA3943@opensource.wolfsonmicro.com>
Message-ID: <4FCDAD5B.8010106@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/12 19:16, Mark Brown wrote:
> On Mon, Jun 04, 2012 at 10:19:37AM +0200, Sascha Hauer wrote:
>> On Mon, Jun 04, 2012 at 02:42:28PM +1000, Greg Ungerer wrote:
>
>>> Trivially we could conditionalize the code block that calls
>>> devm_clk_get() in the probe routine, but that is kind of ugly.
>
>> It's ugly, but the only other solution I see is that you could provide a
>> dummy devm_clk_get() for coldfire. Added Mark to Cc, maybe he has
>> another idea?
>
> Not really, I think if the clock API is going to be usable we really
> need the platforms to all be implementing it.  Part of this is getting
> the stubs for !HAVE_CLK cases implemented (which doesn't seem to have
> happened :/) ).  We do need to address this at the framework level,
> having to put ifdefs in all the drivers is obviously awful.

Is this something you intend "fixing" then?

I don't mind putting a simplistic (but do nothing) place holder for
this function along with the other stubbed clk functions in the m68k/
coldfire code.

But more generally I am wondering does it make sense to be working
on specific platform clocks in a multi-platform/arch driver?

Regards
Greg


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
