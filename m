From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 11:53:32 +0100
Subject: [PATCH 8/9] serial: sirf: Fix out-of-bounds access through DT
 alias
In-Reply-To: <1519119624-1268-9-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-9-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdUymMioYc=ifKMZEZ8tU+D=JXH7b+LsLR4d_EDhbEPkcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 10:40 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The sirf_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Fixes: 66c7ab1120585d18 ("serial: sirf: Fix out-of-bounds access through DT alias")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Fixes: a6ffe8966acbb66b ("serial: sirf: use dynamic method allocate
uart structure")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
