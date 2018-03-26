From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Mar 2018 10:39:13 +0200
Subject: [PATCH] spi: spi-atmel: Use correct enum for DMA transfer
 direction
In-Reply-To: <20180324104800.9934-1-stefan@agner.ch>
References: <20180324104800.9934-1-stefan@agner.ch>
Message-ID: <CAMuHMdUk+_0jcDL2NAB4WywjUq2i0EWf=k8GZTWhR5FhNOK=cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 24, 2018 at 11:48 AM, Stefan Agner <stefan@agner.ch> wrote:
> Use enum dma_transfer_direction as required by the functions
> dmaengine_prep_slave_(sg|single)() instead of enum dma_data_direction.
> This won't change behavior in practice as the enum values are
> equivalent.
>
> This fixes two warnings when building with clang:
>   drivers/spi/spi-atmel.c:771:12: warning: implicit conversion from enumeration
>       type 'enum dma_data_direction' to different enumeration type
>       'enum dma_transfer_direction'
>       [-Wenum-conversion]
>                                                      DMA_FROM_DEVICE,
>                                                      ^~~~~~~~~~~~~~~
>   ...
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
