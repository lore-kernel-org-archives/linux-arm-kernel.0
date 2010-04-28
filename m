From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 28 Apr 2010 15:25:41 +0900
Subject: CONSISTENT_DMA_SIZE limitations
Message-ID: <v2taec7e5c31004272325x9e5958ddp34d7db1ff3477f4d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Are there any special CONSISTENT_DMA_SIZE limitiations in the latest
upstrem ARM kernel?

On SH-Mobile ARM a single 256 MB I/O window is mapped virt:phys 1:1 at
0xe6000000 -> 0xf5ffffff at ->map_io() time.

The virtual area on top of the I/O window at 0xf6000000 -> 0xffdfffff
seems suitable for consistent dma mappings. Extending
CONSISTENT_DMA_SIZE from the default 2MB to 158 MB makes efficient use
of the entire range. Empty 2MB space is left at the top as usual.

Extending CONSISTENT_DMA_SIZE seems like a good idea to me, but I'm
not sure if doing so will break something else. Perhaps I need to
rework some code in arch/arm/mm/dma-mapping.c?

I'm asking because most platforms only export up to 14 MB, and
Documentation/arm/memory.txt mentions 0xff000000 -> 0xffbfffff as
reserved.

Thanks!

/ magnus
