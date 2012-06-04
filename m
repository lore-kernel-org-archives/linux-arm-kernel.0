From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Jun 2012 10:16:16 +0100
Subject: Freescale fec.c driver breakage
In-Reply-To: <20120604081937.GH30400@pengutronix.de>
References: <4FCC3CB4.5030107@snapgear.com>
 <20120604081937.GH30400@pengutronix.de>
Message-ID: <20120604091616.GA3943@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2012 at 10:19:37AM +0200, Sascha Hauer wrote:
> On Mon, Jun 04, 2012 at 02:42:28PM +1000, Greg Ungerer wrote:

> > Trivially we could conditionalize the code block that calls
> > devm_clk_get() in the probe routine, but that is kind of ugly.

> It's ugly, but the only other solution I see is that you could provide a
> dummy devm_clk_get() for coldfire. Added Mark to Cc, maybe he has
> another idea?

Not really, I think if the clock API is going to be usable we really
need the platforms to all be implementing it.  Part of this is getting
the stubs for !HAVE_CLK cases implemented (which doesn't seem to have
happened :/) ).  We do need to address this at the framework level,
having to put ifdefs in all the drivers is obviously awful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120604/999edd21/attachment.sig>
