From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 8 Jul 2014 09:15:27 +0200
Subject: [PATCH] of: Use proper types for checking memory overflow
In-Reply-To: <1404780343-32188-1-git-send-email-lauraa@codeaurora.org>
References: <1404780343-32188-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAMuHMdX0Bab6XZsujiNcCfaPLGn7-hDdcoJFYUB1UO+HNPUFww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 8, 2014 at 2:45 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
> Commit a67a6ed15513541579d38bcbd127e7be170710e5
> (of: Check for phys_addr_t overflows in early_init_dt_add_memory_arch)
> corrected early_init_dt_add_memory_arch to account for overflows
> but did so in an unclean way using ULONG_MAX. There is no
> guarantee that sizeof(unsigned long) == sizeof(phys_addr_t).
> Check against phys_addr_t instead.

Thanks!

> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
