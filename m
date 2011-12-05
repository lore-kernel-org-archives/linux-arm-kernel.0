From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Dec 2011 19:15:46 +0100
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <20111205180253.GB29812@localhost.localdomain>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
Message-ID: <CAMuHMdXQ0TahPcwDiLsN5s0rLRny3WcFLnCw-R_ZFkuO0T1RrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 5, 2011 at 19:02, Dave Martin <dave.martin@linaro.org> wrote:
> Unfortunately, NO_IRQ is often not spelled "NO_IRQ". ?It looks like the assumption
> "irq < 0 === no irq" may be quite a lot more widespread than "NO_IRQ === no irq".

Can we make irq unsigned, and hope the compiler catches all of them
(comparison always
false blah blah blah)?

Gr{oetje,eeting}s,

? ? ? ? ? ? ? ? ? ? ? ? Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?? -- Linus Torvalds
