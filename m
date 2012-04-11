From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 Apr 2012 11:31:07 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120411094136.GX24211@n2100.arm.linux.org.uk>
References: <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
 <20120410143055.GT24211@n2100.arm.linux.org.uk>
 <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
 <20120411091548.GD3163@opensource.wolfsonmicro.com>
 <20120411092147.GW24211@n2100.arm.linux.org.uk>
 <20120411093253.GF3163@opensource.wolfsonmicro.com>
 <20120411094136.GX24211@n2100.arm.linux.org.uk>
Message-ID: <20120411103107.GG3163@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 10:41:36AM +0100, Russell King - ARM Linux wrote:

> clkdev is just a mechanism to obtain a struct clk for a particular input
> on a particular device.  Nothing more, nothing less.  So how does this
> detail about how the struct clk ultimate gets used concern clkdev?

It shouldn't.  

The main point I'm trying to make is that if we're adding an alternative
mechanism to the direct pointers for specifying the bindings to clkdev
(which is broadly the point of the original patch, AFAICT based on a
desire to split the mapping out from the definitions) then having it rely
on device tree in the first instance means we'll just need to solve the
same problem again for non-DT systems.  Richard was saying that the
problem Sascha was trying to solve is irrelevant because we can rely on
device tree but device tree is not widely available enough for that.

The bit about clock to clock mappings was mostly an aside since it seems
like it's roughly the same as what Sascha was trying to do and if we're
going to add something new it'd be better if it handled that case also;
that said re-reading Richard's message I'm not sure if this is actually
a suggestion of a new mechanism.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120411/eb2f1efe/attachment.sig>
