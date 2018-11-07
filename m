From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 7 Nov 2018 09:38:47 +0100
Subject: [PATCH] of/device: Really only set bus DMA mask when appropriate
In-Reply-To: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
Message-ID: <CAMuHMdW+=cVUBBzS7F990Wci4VKOzOqtYVeVOH9s3u0X7R95xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Tue, Nov 6, 2018 at 12:54 PM Robin Murphy <robin.murphy@arm.com> wrote:
> of_dma_configure() was *supposed* to be following the same logic as
> acpi_dma_configure() and only setting bus_dma_mask if some range was
> specified by the firmware. However, it seems that subtlety got lost in
> the process of fitting it into the differently-shaped control flow, and
> as a result the force_dma==true case ends up always setting the bus mask
> to the 32-bit default, which is not what anyone wants.
>
> Make sure we only touch it if the DT actually said so.
>
> Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks, this fixes the problem I saw with IPMMU on Salvator-X(S).

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
