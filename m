From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 11 Nov 2012 10:45:51 +0100
Subject: [PATCH 02/11] time: convert arch_gettimeoffset to a pointer
In-Reply-To: <1352408516-21988-4-git-send-email-swarren@wwwdotorg.org>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
 <1352408516-21988-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAMuHMdWCFDk_DTs3T-h_8NvmsaQ1bbPyj1vJyN_y=fCeMT06sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2012 at 10:01 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Currently, whenever CONFIG_ARCH_USES_GETTIMEOFFSET is enabled, each
> arch core provides a single implementation of arch_gettimeoffset(). In
> many cases, different sub-architectures, different machines, or
> different timer providers exist, and so the arch ends up implementing
> arch_gettimeoffset() as a call-through-pointer anyway. Examples are
> ARM, Cris, M68K, and it's arguable that the remaining architectures,
> M32R and Blackfin, should be doing this anyway.
>
> Modify arch_gettimeoffset so that it itself is a function pointer, which
> the arch initializes. This will allow later changes to move the
> initialization of this function into individual machine support or timer
> drivers. This is particularly useful for code in drivers/clocksource
> which should rely on an arch-independant mechanism to register their
> implementation of arch_gettimeoffset().
>
> This patch also converts the Cris architecture to set arch_gettimeoffset
> directly to the final implementation in time_init(), because Cris already
> had separate time_init() functions per sub-architecture. M68K and ARM
> are converted to set arch_gettimeoffset the final implementation in later
> patches, because they already have function pointers in place for this
> purpose.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Hirokazu Takata <takata@linux-m32r.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>

The m68k changes look ok, so

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: John Stultz <johnstul@us.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
