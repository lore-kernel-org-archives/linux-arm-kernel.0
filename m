From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 23 Sep 2014 10:27:37 +0200
Subject: [PATCH] ARM: shmobile: Remove ARCH_HAS_OPP completely
In-Reply-To: <1411459730.20236.6.camel@x220>
References: <1406551632.5397.17.camel@x220> <1410511111.31130.4.camel@x220>
 <20140916000916.GD9847@verge.net.au>
 <20140916002333.GI9847@verge.net.au>
 <1411459730.20236.6.camel@x220>
Message-ID: <CAMuHMdUP_SUjAgjhC3hFXjsSzpR=jCP0iaD5AXLWSUkg0V6hig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 10:08 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> The Kconfig symbol ARCH_HAS_OPP became redundant in v3.16: commit
> 049d595a4db3 ("PM / OPP: Make OPP invisible to users in Kconfig")
> removed the only dependency that used it. Setting it had no effect
> anymore.
>
> So commit 78c5e0bb145d ("PM / OPP: Remove ARCH_HAS_OPP") removed it. For
> some reason that commit did not remove all select statements for that
> symbol. These statements are now useless. Remove one from shmobile too.

The explanation for "some reason" is very simple: new selects were introduced
in parallel with the removal of the existing ones.

> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
