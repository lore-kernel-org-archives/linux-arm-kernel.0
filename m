From: gerg@snapgear.com (Greg Ungerer)
Date: Tue, 5 Jun 2012 22:17:02 +1000
Subject: Freescale fec.c driver breakage
In-Reply-To: <20120605094141.GE23408@opensource.wolfsonmicro.com>
References: <4FCC3CB4.5030107@snapgear.com>
 <20120604081937.GH30400@pengutronix.de>
 <20120604091616.GA3943@opensource.wolfsonmicro.com>
 <4FCDAD5B.8010106@snapgear.com>
 <20120605094141.GE23408@opensource.wolfsonmicro.com>
Message-ID: <4FCDF8BE.6010509@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2012 07:41 PM, Mark Brown wrote:
> On Tue, Jun 05, 2012 at 04:55:23PM +1000, Greg Ungerer wrote:
>> On 04/06/12 19:16, Mark Brown wrote:
>
>>> Not really, I think if the clock API is going to be usable we really
>>> need the platforms to all be implementing it.  Part of this is getting
>>> the stubs for !HAVE_CLK cases implemented (which doesn't seem to have
>>> happened :/) ).  We do need to address this at the framework level,
>>> having to put ifdefs in all the drivers is obviously awful.
>
>> Is this something you intend "fixing" then?
>
> No, if I were going to do anything here it'd be converting everything
> over to the common clock API so we didn't have to deal with this sort
> of issue, it really makes the clock API unusable for generic code.
>
>> I don't mind putting a simplistic (but do nothing) place holder for
>> this function along with the other stubbed clk functions in the m68k/
>> coldfire code.
>
>> But more generally I am wondering does it make sense to be working
>> on specific platform clocks in a multi-platform/arch driver?
>
> Yes, if it's a reusable IP then it's going to have a fixed set of clocks
> which go into it regardless of which platform it's hooked up to.

I really don't think you can make that assumption here. Freescale have
come up with a number of weird and slightly different permutations of
this ethernet core.


> clkdev
> provides an abstraction which can map these onto the platform, even if
> you don't use the generic clk API clkdev is still very useful and will
> help with a lot of these issues.

In this specific case I don't know what the ipg or ahb clocks are on iMX
(Sascha?), but there is nothing equivalent to them in the FEC cores used
on existing ColdFire CPUs. They seem to be platform specific (iMX) more
than FEC driver specific.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
