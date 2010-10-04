From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Mon, 04 Oct 2010 09:29:07 +0300
Subject: multiple linux-next OMAP3 build errors
In-Reply-To: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
References: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
Message-ID: <1286173747.2358.4.camel@tubuntu.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2010-10-01 at 17:57 +0200, ext Grazvydas Ignotas wrote:
> hi,
> 
> I've been building linux-next for a while now and keep getting these
> build errors, just posting them here in case not all are known. Not
> familiar enough with that code to send patches unfortunately.

>   CC      drivers/video/omap2/vram.o
> drivers/video/omap2/vram.c: In function 'omap_vram_reserve_sdram_memblock':
> drivers/video/omap2/vram.c:568: error: implicit declaration of
> function 'memblock_region_is_memory'

Benjamin, your patch "memblock/arm: Use memblock_region_is_memory() for
omap fb" in linux-next seems to be broken. I believe the called function
should be memblock_is_region_memory, not memblock_region_is_memory?

 Tomi
