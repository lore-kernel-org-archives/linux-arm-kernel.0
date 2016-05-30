From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 30 May 2016 14:11:51 +0200
Subject: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <20160530112610.GJ29837@sirena.org.uk>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk>
Message-ID: <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, May 30, 2016 at 1:26 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, May 26, 2016 at 07:25:25PM -0000, Michal Suchanek wrote:
>>  - fallback to previous behaviour when DMA initialization fails
>>
>>    + this has the problem that when the driver happens to load before the dma
>>      driver it will not use dma - can be addressed with a module parameter
>
> No, you should pay attention to the error you are getting and let probe
> deferral happen if that's the error you get.

Unfortunately DMA is an optional feature.

There's no way to distinguish between -EPROBE_DEFER due to the SPI master
driver being probed before the DMA engine driver, and -EPROBE_DEFER due to
support for the DMA engine not having been compiled in.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
