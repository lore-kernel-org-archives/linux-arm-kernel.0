From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Apr 2012 17:33:19 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120411114311.GZ24211@n2100.arm.linux.org.uk>
References: <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
 <20120411091548.GD3163@opensource.wolfsonmicro.com>
 <20120411092147.GW24211@n2100.arm.linux.org.uk>
 <20120411093253.GF3163@opensource.wolfsonmicro.com>
 <20120411094136.GX24211@n2100.arm.linux.org.uk>
 <20120411103107.GG3163@opensource.wolfsonmicro.com>
 <20120411114311.GZ24211@n2100.arm.linux.org.uk>
Message-ID: <20120412163319.GE3195@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 12:43:11PM +0100, Russell King - ARM Linux wrote:

> What I see going on is that people want to translate a device + connection
> ID to some other name, and use this other name to look up a struct clk.
> Utterly idiotic and pointless.  Whether it be OF or not OF.

> It's a crazy absurd idea.  At some point, you have to do some kind of
> lookup and return a struct clk.  Why the hell have this insane double
> mapping?

I agree, that is silly.  I had understood from Sascha's comments that
the use case was building up the SoC clock tree with some indirect
references.  I can understand someone wanting to do that for a use case
like grafting chunks of tree built up of static data together, it might
be a bit more nicely data driven.

> Look, solving the DT problem with clkdev is really simple.  You have the
> DT node for the struct device, so you can look up DT properties associated

Yes, DT is completely straightforward here.

> And it also allows non-DT to work just fine provided you register your
> clk lookups _after_ you know the struct clk pointers which is exactly what
> happens today.

> Now, if getting the struct clk pointers is insanely difficult because of
> the design of the common clk stuff, then that's where the problem lies,
> and that problem needs to be fixed, and clkdev does not need to be bodged
> around to fix a problem which is not relevant to it.

I don't think it's anything particularly to do with the common clk stuff
really (at least I share your opinion that it shouldn't be) but it does
seem like it might be a real pain once we start deploying clock trees
that go off SoC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120412/6f2bafb0/attachment.sig>
