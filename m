From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Jun 2013 21:53:29 +0900
Subject: About LPAE supporting on EXYNOS5440
In-Reply-To: <201306121158.20676.arnd@arndb.de>
References: <109e01ce667e$5becc880$13c65980$%kim@samsung.com>
 <15605927.1Yi6Xe5hWs@wuerfel> <51B7FD2E.9030306@gmail.com>
 <201306121158.20676.arnd@arndb.de>
Message-ID: <151501ce6835$0109d4e0$031d7ea0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Wednesday 12 June 2013, Subash Patel wrote:
> > > I would definitely leave on exynos5440 support in defconfig. It's not
> a
> > > lot of extra code, and if you have a system with less than 4GB memory,
> > > you really don't want to enable LPAE because of the overhead.
> >
> > Even if we have <= 4GB memory, and the system designers have placed the
> > memory banks in addresses > 2^32 bytes, then we need LPAE support. I
> > think we may have such systems in future. So memory capacity is not the
> > only parameter to judge if we need to enable LPAE or not.
> 
> Yes, but that wasn't the point. You can always build systems with
> exynos5440 that don't need LPAE, so we should not assume that it is
> not a reasonable configuration.
> 
Agreed.

> I would certainly advise system designers to put all the RAM and I/O
> into normally addressable locations if possible to avoid the need
> for LPAE, but of course that isn't always possible.
> 
Yes, same here. Actually, some IPs sometimes can request to alloc/use
something like dma buffer over 32 bit area after LPAE enabling, but will not
be happened without LPAE.

> We should probably have someone measure the performance impact
> of LPAE as well. If it's less than a few percent, we might not
> care all that much.
> 
Yes, after testing on exynos5440 board, LPAE doesn't cause any performance
degradation with lmbench tool.

- Kukjin
