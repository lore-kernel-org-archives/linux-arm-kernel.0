From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 Feb 2015 09:45:43 +0100
Subject: Build regressions/improvements in v4.0-rc1
In-Reply-To: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdXnVLtiSxqwz7ah5faPUx_8piN5eOdNKQtKNwOgT73FqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 9:33 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.0-rc1[1] compared to v3.19[2].
>
> Summarized:
>   - build errors: +11/-10

> [1] http://kisskb.ellerman.id.au/kisskb/head/8494/ (256 out of 257 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/8427/ (255 out of 257 configs)
>
>
> *** ERRORS ***
>
> 11 regressions:
>   + /home/kisskb/slave/src/arch/arm/include/asm/atomic.h: error: #error SMP not supported on pre-ARMv6 CPUs:  => 137:2
>   + /home/kisskb/slave/src/arch/arm/include/asm/cmpxchg.h: error: #error "SMP is not supported on this platform":  => 114:2

arm-randconfig

SMP does depend on CPU_V6K || CPU_V7 and on HAVE_SMP... strange...

>   + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2

sh-randconfig

>   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]:  => 55:2
>   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_direction_output' [-Werror=implicit-function-declaration]:  => 61:2
>   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]:  => 30:3

s390-allyesconfig
s390-allmodconfig
parisc-allmodconfig
sh-allmodconfig
sh-allyesconfig
cris-allyesconfig
cris-allmodconfig
mips-allmodconfig

>   + error: asm9260_timer.c: undefined reference to `of_io_request_and_map':  => .init.text+0x4014), .init.text+0x5c84)

sparc64-allmodconfig
sparc-allmodconfig

>   + error: book3s_64_vio_hv.c: undefined reference to `power7_wakeup_loss':  => .text+0x408)

pseries_defconfig

>   + error: smp.c: undefined reference to `.__flush_disable_L1':  => .text+0xb24)

powerpc-randconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
