From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 Apr 2012 10:32:54 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120411092147.GW24211@n2100.arm.linux.org.uk>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
 <20120410143055.GT24211@n2100.arm.linux.org.uk>
 <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
 <20120411091548.GD3163@opensource.wolfsonmicro.com>
 <20120411092147.GW24211@n2100.arm.linux.org.uk>
Message-ID: <20120411093253.GF3163@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 10:21:47AM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 11, 2012 at 10:15:49AM +0100, Mark Brown wrote:
> > On Wed, Apr 11, 2012 at 04:45:29PM +0800, Richard Zhao wrote:
> > > a clk, one already got the struct clk* pointer and could use it in
> > > struct lookup.

> > How will you handle cases where one clock supplies another?

> What has that got to do with clkdev (which is the topic in this thread)?

I'm expecting (well, hoping) that at some point we'll want to connect
clock trees between devices and it seems likely that clkdev will be
pressed into service for that since it's how we're binding clocks at the
minute.  It may be that we come up with some other scheme for making
those connections but as we appear to be defining a new scheme for
binding clocks together anyway it seems sensible that we should at least
be considering that case.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120411/bf7b8f1a/attachment-0001.sig>
