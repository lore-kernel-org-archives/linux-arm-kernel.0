From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 15:03:22 +0000
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120509144241.GW3955@opensource.wolfsonmicro.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205091419.50736.arnd@arndb.de>
 <20120509144241.GW3955@opensource.wolfsonmicro.com>
Message-ID: <201205091503.22950.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Mark Brown wrote:
> That's what I'd expect, but you're saying that the values in the child
> resources are being stored as base+actual values (where base is some
> random number) rather than either actual values or as offsets within the
> base range either of which would seem less surprising.  Presumably you'd
> also need to walk up the tree to subtract all the bases if there was
> more than one resource.
> 
> Perhaps I'm just totally failing to understand what you're saying?

I mean that each device providing resources of the new type would need
to register its resources to the same root resource with non-conclicting
addresses. Having resources hanging in the air without a parent pointer
is not good, although we seem to be doing that for a lot of platform
devices these days, where we just pass the struct resource from platform
code to a driver without ever registering it at each end.

	Arnd
