From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 23 May 2013 10:40:29 +0200
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
In-Reply-To: <519DCBEF.3090208@asianux.com>
References: <519DCBEF.3090208@asianux.com>
Message-ID: <CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 9:57 AM, Chen Gang <gang.chen@asianux.com> wrote:
> The crazy user can unset 'CONFIG_BUG' in menuconfig: "> General setup >
> Configure standard kernel features (expert users) > BUG() Support".
>
> But in fact, we always need it, and quite a few of architectures have

Sorry, but we don't. I think you don't get the meaning of the BUG config symbol
(see below).

> already implemented it (e.g. alpha, arc, arm, avr32, blackfin, cris,
> frv, ia64, m68k, mips, mn10300, parisc, powerpc, s390, sh, sparc, x86).

What do you mean by "already implemented it"? E.g. on m68k, I can disable
or enable CONFIG_BUG. Both work.

> And kernel also already has prepared a default effective implementation
> for the architectures which is unwilling to implement it by themselves
> (e.g. arm64, c6x, h8300, hexagon, m32r, metag, microblaze, openrisc,
> score, tile, um, unicore32, xtensa).

This is not about providing an implementation or not...

> -config BUG
> -       bool "BUG() support" if EXPERT
> -       default y
> -       help
> -          Disabling this option eliminates support for BUG and WARN, reducing
> -          the size of your kernel image and potentially quietly ignoring
> -          numerous fatal conditions. You should only consider disabling this
> -          option for embedded systems with no facilities for reporting errors.
> -          Just say Y.

... It's about reducing memory size on devices where you can't show bug or
warning messages.

> So need get rid of 'CONFIG_BUG', and let it always enabled everywhere.

So please keep it.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
