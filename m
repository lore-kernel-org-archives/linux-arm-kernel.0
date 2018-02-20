From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 11:51:49 +0100
Subject: [PATCH 4/9] serial: mxs-auart: Fix out-of-bounds access through
 DT alias
In-Reply-To: <1519119624-1268-5-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-5-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdW8LHTd4q9q_pL97W1vtM68x+Fep8QjCx_O2sNre1CNng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 10:40 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The auart_port[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Fixes: cabf23e7aa00b145 ("serial: mxs-auart: Fix out-of-bounds access through DT alias")

Fixes: 1ea6607d4cdc9179 ("serial: mxs-auart: Allow device tree probing")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
