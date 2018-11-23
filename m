From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 23 Nov 2018 11:49:18 +0100
Subject: remove the ->mapping_error method from dma_map_ops V2
In-Reply-To: <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
 <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
Message-ID: <20181123104918.GE1586@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 05:52:15PM +0000, Robin Murphy wrote:
> Unfortunately, with things like the top-down IOVA allocator, and 32-bit
> systems in general, "the top 4095" values may well still be valid addresses
> - we're relying on a 1-byte mapping of the very top byte of memory/IOVA
> space being sufficiently ridiculous that no real code would ever do that,
> but even a 4-byte mapping of the top 4 bytes is within the realms of the
> plausible (I've definitely seen the USB layer make 8-byte mappings from any
> old offset within a page, for example).

But we can easily work around that by reserving the top 4k of the first
4GB of IOVA address space in the allocator, no? Then these values are
never returned as valid DMA handles.


Regards,

	Joerg
