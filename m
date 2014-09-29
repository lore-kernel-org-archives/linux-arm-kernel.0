From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Sep 2014 10:54:34 +0200
Subject: [PATCH v4 6/8] asm-generic/io.h: Implement generic {read,
 write}s*()
In-Reply-To: <1407925738-26170-7-git-send-email-thierry.reding@gmail.com>
References: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
 <1407925738-26170-7-git-send-email-thierry.reding@gmail.com>
Message-ID: <CAMuHMdW4emoma3nRUGna985tE17yPh5pNjMb-jxe5yc5UVr=cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 12:28 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> #ifndef memset_io
> -#define memset_io(a, b, c)     memset(__io_virt(a), (b), (c))
> +#define memset_io memset_io
> +static inline void memset_io(void __iomem *addr, int value, size_t size)
> +{
> +       memset(__io_virt(addr), value, size);
> +}
>  #endif

xtensa/allmodconfig:

include/asm-generic/io.h:820:2: error: implicit declaration of
function 'memset' [-Werror=implicit-function-declaration]
include/asm-generic/io.h:829:2: error: implicit declaration of
function 'memcpy' [-Werror=implicit-function-declaration]
arch/xtensa/include/asm/string.h:110:14: error: conflicting types for 'memset'
arch/xtensa/include/asm/string.h:113:14: error: conflicting types for 'memcpy'

http://kisskb.ellerman.id.au/kisskb/buildresult/12028900/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
