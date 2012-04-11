From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 Apr 2012 10:15:49 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120411084528.GB20818@b20223-02.ap.freescale.net>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
 <20120410143055.GT24211@n2100.arm.linux.org.uk>
 <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
Message-ID: <20120411091548.GD3163@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 04:45:29PM +0800, Richard Zhao wrote:
> On Wed, Apr 11, 2012 at 09:24:02AM +0100, Mark Brown wrote:

> > No, this is only useful on platforms that use DT.  This is a generic
> > Linux API so it needs to support architectures and platforms that don't
> > use DT as it's vanishingly unlikely that DT will ever be adopted by all
> > platforms.

> My point is using string lookup as less as possible. When one register

That's not really relevant to what I'm saying here - I'm not commenting
on your goal, I'm commenting on the solution.  Obviously we want to be
able to use things with DT but if we rely on it then we still need to
solve the same problem for non-DT platforms.

> a clk, one already got the struct clk* pointer and could use it in
> struct lookup.

How will you handle cases where one clock supplies another?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120411/3a29c1c3/attachment.sig>
