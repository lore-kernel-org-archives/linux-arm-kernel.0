From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Oct 2017 11:19:19 +0000
Subject: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <20171027010841.28624-2-tpiepho@impinj.com>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
Message-ID: <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 26, 2017 at 06:08:38PM -0700, Trent Piepho wrote:
> The driver will fail to load if no gpio chip selects are specified,
> this patch changes this so that it no longer fails.
> 
> It's possible to use all native chip selects, in which case there is
> no reason to have a gpio chip select array.  This is what happens if
> the *optional* device tree property "cs-gpios" is omitted.

Do the native chip selects actually work usefully on this hardware?
There used to be problems with it wanting to do things like bounce the
chip select on every word which made it extremely difficult to use with
Linux.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171031/7298bf15/attachment.sig>
