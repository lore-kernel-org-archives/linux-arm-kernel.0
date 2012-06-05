From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jun 2012 10:41:41 +0100
Subject: Freescale fec.c driver breakage
In-Reply-To: <4FCDAD5B.8010106@snapgear.com>
References: <4FCC3CB4.5030107@snapgear.com>
 <20120604081937.GH30400@pengutronix.de>
 <20120604091616.GA3943@opensource.wolfsonmicro.com>
 <4FCDAD5B.8010106@snapgear.com>
Message-ID: <20120605094141.GE23408@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 04:55:23PM +1000, Greg Ungerer wrote:
> On 04/06/12 19:16, Mark Brown wrote:

> >Not really, I think if the clock API is going to be usable we really
> >need the platforms to all be implementing it.  Part of this is getting
> >the stubs for !HAVE_CLK cases implemented (which doesn't seem to have
> >happened :/) ).  We do need to address this at the framework level,
> >having to put ifdefs in all the drivers is obviously awful.

> Is this something you intend "fixing" then?

No, if I were going to do anything here it'd be converting everything
over to the common clock API so we didn't have to deal with this sort
of issue, it really makes the clock API unusable for generic code.

> I don't mind putting a simplistic (but do nothing) place holder for
> this function along with the other stubbed clk functions in the m68k/
> coldfire code.

> But more generally I am wondering does it make sense to be working
> on specific platform clocks in a multi-platform/arch driver?

Yes, if it's a reusable IP then it's going to have a fixed set of clocks
which go into it regardless of which platform it's hooked up to.  clkdev
provides an abstraction which can map these onto the platform, even if
you don't use the generic clk API clkdev is still very useful and will
help with a lot of these issues.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120605/1231dcd6/attachment.sig>
