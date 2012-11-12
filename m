From: notasas@gmail.com (Grazvydas Ignotas)
Date: Mon, 12 Nov 2012 15:39:45 +0200
Subject: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
In-Reply-To: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 12, 2012 at 12:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> This series changes omapfb to use standard dma_alloc funcs instead of omap
> specific vram allocator. This let's us remove the omap vram allocator, making
> omapfb platform independent.
>
> However, note that using standard dma funcs causes the following downsides:
>
> ...
>
> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
> changed the ioctl to return 64M for all the values, which, I hope, the
> applications will interpret as "there's enough vram".

Do at least OMAPFB_QUERY_MEM/OMAPFB_SETUP_MEM still work?

> 4) "vram" kernel parameter to define how much ram to reserve for video use no
> longer works. The user needs to enable CMA and use "cma" parameter.

That's a significant change, you should update Documentation/ .
What about omapfb.vram, is it still there?
Perhaps we also need to select/depend on CMA?


-- 
Gra?vydas
