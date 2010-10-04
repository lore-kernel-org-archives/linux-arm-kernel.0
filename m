From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 05 Oct 2010 09:30:22 +1100
Subject: multiple linux-next OMAP3 build errors
In-Reply-To: <1286173747.2358.4.camel@tubuntu.research.nokia.com>
References: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
	<1286173747.2358.4.camel@tubuntu.research.nokia.com>
Message-ID: <1286231422.2463.316.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-04 at 09:29 +0300, Tomi Valkeinen wrote:
> >   CC      drivers/video/omap2/vram.o
> > drivers/video/omap2/vram.c: In function
> 'omap_vram_reserve_sdram_memblock':
> > drivers/video/omap2/vram.c:568: error: implicit declaration of
> > function 'memblock_region_is_memory'
> 
> Benjamin, your patch "memblock/arm: Use memblock_region_is_memory()
> for
> omap fb" in linux-next seems to be broken. I believe the called
> function
> should be memblock_is_region_memory, not memblock_region_is_memory?

I suspect either I didn't push my latest version before it got merged or
Yinghai didn't pull the right one, since I'm pretty sure I test built
it, but in any case, you're probably right :-)

I'm not in control of this patch series at the moment however. Ingo and
Yinghai are. Yinghai, care to fix that up ? I'm currently travelling on
holidays and won't be able to do much until later next week.

Cheers,
Ben.
