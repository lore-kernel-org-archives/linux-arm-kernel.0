From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 21 Apr 2017 21:40:04 +0200
Subject: [RFC PATCH 0/2] kbuild: use relative path from $(srctree) instead
 of __FILE__
In-Reply-To: <1492801407-26823-1-git-send-email-yamada.masahiro@socionext.com>
References: <1492801407-26823-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAMuHMdXnVucvnojMzqumvTOn=QwdDpr8FdfykjJHhtdGzO_Cyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yamada-san,

On Fri, Apr 21, 2017 at 9:03 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Kbuild works in objtree, not in srctree.  So, __FILE__ is prefixed
> with $(srctree)/ for out-of-tree build.
>
> It would be nice to see the same log regardless
> in-tree, or out-of-tree build.
>
> 1/2 adds a new macro KBUILD_FILE.  This points the relative path
> of the file we are building.  This is intended to replace __FILE__.
>
> 2/2 replaces __FILE__ in bug.h as an example.  This will improve
> the output of WARN_ON() etc.

I haven't tried your series, but I love the idea behind it!
I never liked exposing full file paths in kernel images.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
