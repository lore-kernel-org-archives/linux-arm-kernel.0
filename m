From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 8 Dec 2015 17:30:02 +0100
Subject: [PATCH] mtd: sh_flctl: pass FIFO as physical address
In-Reply-To: <3152458.D3kElfhRW2@wuerfel>
References: <3152458.D3kElfhRW2@wuerfel>
Message-ID: <CAMuHMdVWss6Kz8sVrcUR3a4iJ+Z8D1q1Er6eH_uRMoS5DCN5pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 8, 2015 at 4:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> By convention, the FIFO address we pass using dmaengine_slave_config
> is a physical address in the form that is understood by the DMA
> engine, as a dma_addr_t, phys_addr_t or resource_size_t.
>
> The sh_flctl driver however passes a virtual __iomem address that
> gets cast to dma_addr_t in the slave driver. This happens to work
> on shmobile because that platform sets up an identity mapping for
> its MMIO regions, but such code is not portable to other platforms,
> and prevents us from ever changing the platform mapping or reusing
> the driver on other architectures like ARM64 that might not have the
> mapping.

Note that since the removal of (ARM) sh7367/sh7377/sh7372 support, this
driver is used on SH only.

I'll send a patch to update Kconfig.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
