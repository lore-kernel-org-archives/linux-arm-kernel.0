From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 10 Feb 2013 20:06:36 +0100
Subject: ixp4xx eth broken in 3.7.0/3.8-rc5?
In-Reply-To: <20744.9777.937924.822371@pilspetsen.it.uu.se> (Mikael
 Pettersson's message of "Tue, 29 Jan 2013 20:42:41 +0100")
References: <20744.9777.937924.822371@pilspetsen.it.uu.se>
Message-ID: <m34nhk9ef7.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

> When I try to update my ixp4xx machine to a 3.8-rc5 kernel it boots
> Ok but the network (CONFIG_IXP4XX_ETH=y) fails to come up, with the
> following in the kernel log:
>
> net eth0: coherent DMA mask is unset
>
> With a 3.7.0 kernel the situation is similar, except that the "net
> eth0: coherent DMA mask is unset" message repeats itself endlessly
> and I can't even get in on the serial console.
>
> With the 3.6.0 kernel everything works perfectly.

I haven't yet tried the Ethernet driver but it seems my IXP425 box
doesn't like this while mounting a disk (PCI CS3356-based IDE CF card).

commit e9da6e9905e639b0f842a244bc770b48ad0523e9
Author: Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon Jul 30 09:11:33 2012 +0200

    ARM: dma-mapping: remove custom consistent dma region

    This patch changes dma-mapping subsystem to use generic vmalloc areas
    for all consistent dma allocations. This increases the total size limit
    of the consistent allocations and removes platform hacks and a lot of
    duplicated code.

    Atomic allocations are served from special pool preallocated on boot,
    because vmalloc areas cannot be reliably created in atomic context.

This is post-3.5, pre-3.6. Could be a bug in some (not yet upstream)
support code, checking. I wouldn't even mention this except for it
touches this same coherent alloc thing.
-- 
Krzysztof Halasa
