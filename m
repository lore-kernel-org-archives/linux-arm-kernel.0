From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 Feb 2015 10:14:55 +0100
Subject: Build regressions/improvements in v4.0-rc1
In-Reply-To: <5900255.NhXvduRnha@wuerfel>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXnVLtiSxqwz7ah5faPUx_8piN5eOdNKQtKNwOgT73FqA@mail.gmail.com>
 <5900255.NhXvduRnha@wuerfel>
Message-ID: <CAMuHMdVMCvw1euM0c2AYrYibO4ObZLV6F_-CDPZZ6x44D6Hwug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 10:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >   + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2
>
> DAX support was merged with 'depends on !(ARM || MIPS || SPARC)', so I don't
> see how this could happen.

sh is not ARM, not MIPS, not SPARC, so...?

>> sh-randconfig

>> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]:  => 55:2
>> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_direction_output' [-Werror=implicit-function-declaration]:  => 61:2
>> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]:  => 30:3
>
> Something wrong in arch/sh/include/asm/gpio.h? the codec is only
> selectable when gpiolib is enabled, but the consumer.h header
> apparently does not get included here.

I think it's an bad select, for which a patch has been available since
about 2 weeks.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
