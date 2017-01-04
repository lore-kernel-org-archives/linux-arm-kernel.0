From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 Jan 2017 10:27:32 +0100
Subject: [PATCH 1/3] linux/const.h: move UL() macro to
 include/linux/const.h
In-Reply-To: <1483520127-29316-2-git-send-email-yamada.masahiro@socionext.com>
References: <1483520127-29316-1-git-send-email-yamada.masahiro@socionext.com>
 <1483520127-29316-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAMuHMdVyzF4xFPotburrP+cihjfyCDfHeAt4bienLG9kdG_zSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yamada-san,

On Wed, Jan 4, 2017 at 9:55 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Some architectures are duplicating the definition of UL():
>
>   #define UL(x) _AC(x, UL)
>
> This is not actually arch-specific, so it will be useful to move it
> to a common header.  Currently, we only have the uapi variant for
> linux/const.h, so I am creating include/linux/const.h.
>
> I am also adding _UL(x), _ULL(x), ULL(x) because _AC() is used for
> UL in most places (and ULL in some places).  I expect _AC(..., UL)
> will be replaced with _UL(...) or UL(...).  The underscore-prefixed
> one should be used for exported headers.
>
> Note:
> I renamed UL(x) in arch/m68k/mm/init.c, where it is used for a
> different meaning.

Shouldn't that be a separate (prerequisite) patch?

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/include/asm/memory.h       | 6 ------
>  arch/arm64/include/asm/memory.h     | 6 ------
>  arch/m68k/mm/init.c                 | 6 +++---
>  arch/unicore32/include/asm/memory.h | 6 ------
>  include/linux/const.h               | 9 +++++++++
>  include/uapi/linux/const.h          | 9 ++++++---
>  6 files changed, 18 insertions(+), 24 deletions(-)
>  create mode 100644 include/linux/const.h

For the m68k change:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
