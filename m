From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 4 Jun 2015 11:30:15 +0200
Subject: [PATCH 10/11] spi: add more debug prints in s3c64xx
In-Reply-To: <20150604091634.GY14071@sirena.org.uk>
References: <cover.1433364398.git.hramrach@gmail.com>
 <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
 <20150604091634.GY14071@sirena.org.uk>
Message-ID: <CAMuHMdWHPm6exq4O3CNvVuiZOgLHuxyCrR548BFmbOPikvNRLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 4, 2015 at 11:16 AM, Mark Brown <broonie@kernel.org> wrote:
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/delay.h>
>>  #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>
> Whatever you're doing here this indicates that there's a very big
> abstraction problem going on.

I guess it's needed for __clk_get_name(), which can be avoided by using
the "%pC" printf format specifier instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
