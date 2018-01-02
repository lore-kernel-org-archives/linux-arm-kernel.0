From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 2 Jan 2018 11:29:10 +0100
Subject: [PATCH 29/67] dma-direct: use node local allocations for coherent
 memory
In-Reply-To: <20171229081911.2802-30-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-30-hch@lst.de>
Message-ID: <CAMuHMdU0_p4RHSKL891YCgej_L2KM5cxmhXDLXVUBXgWoUosVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missing patch description explaining why this change is desirable.

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -39,7 +39,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
>         if (gfpflags_allow_blocking(gfp))
>                 page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
>         if (!page)
> -               page = alloc_pages(gfp, page_order);
> +               page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
>         if (!page)
>                 return NULL;
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
