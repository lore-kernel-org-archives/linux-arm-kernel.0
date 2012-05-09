From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 16:28:28 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205091503.22950.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205091419.50736.arnd@arndb.de>
 <20120509144241.GW3955@opensource.wolfsonmicro.com>
 <201205091503.22950.arnd@arndb.de>
Message-ID: <20120509152827.GA3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 03:03:22PM +0000, Arnd Bergmann wrote:

> I mean that each device providing resources of the new type would need
> to register its resources to the same root resource with non-conclicting

Oh, right - I see what you mean.  I was thinking of creating a
per-chip parent for each tree rather than trying to make them a unified
tree, though I guess it's useful for diagnostics.  Multi-level resources
might be slightly fun with this though I'm not sure how realistic they
are.

> addresses. Having resources hanging in the air without a parent pointer
> is not good, although we seem to be doing that for a lot of platform
> devices these days, where we just pass the struct resource from platform
> code to a driver without ever registering it at each end.

They should all be being registered by the platform core when the
platform device is registered I think?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/c99a5363/attachment-0001.sig>
