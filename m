From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 16:22:44 +0000
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <20140212161206.GD25957@e106331-lin.cambridge.arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <201402121221.51233.arnd@arndb.de>
 <20140212114740.GE21992@e106331-lin.cambridge.arm.com>
 <1786282.mNUF0ZaUg2@wuerfel>
 <20140212161206.GD25957@e106331-lin.cambridge.arm.com>
Message-ID: <20140212162244.GE28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 04:12:06PM +0000, Mark Rutland wrote:

> I thought one of the issues before dt was that clocks were in a global
> namespace. Mark's reply implies that's not necessarily the case, so I'll
> take a tour through clkdev to educate myself.

There's both a global namespace and a device local namespace, the most
exact match is used - see the comment on clk_find().  Remember that in
the past clock implementations didn't have to use clkdev at all so the
implementations varied a lot (which is half the problem with drivers
now).  Lots of implementations just used global clock names and didn't
pay any attention to dev.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/e86b0994/attachment.sig>
