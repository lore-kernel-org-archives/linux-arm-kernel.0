From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 17 Mar 2014 09:01:30 +0100
Subject: [PATCH] ARM: shmobile: lager-reference: Work around core clock
 issues
In-Reply-To: <1395022736-2921-1-git-send-email-horms+renesas@verge.net.au>
References: <1395022736-2921-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdU2xcoR95KC3LFbtjTaULOZQjQKYmbQhZUSteT=EHMbvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 3:18 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Due to issues with runtime PM clock management, clocks not explicitly
> managed by their drivers may not be enabled at all, or be inadvertently
> disabled by the clk_disable_unused() late initcall.
>
> Until this is fixed, add a temporary workaround, calling
> shmobile_clk_workaround() with enable == true.
>
> For now this enables the clocks for: ether, msiof1, qspi_mod, and
> thermal. More clocks can be added if needed.
>
> Based on work for the koelsch board by eert Uytterhoeven.
>
> Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
(if the typo reported by Morimoto-san gets fixed ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
