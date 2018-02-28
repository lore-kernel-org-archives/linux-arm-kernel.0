From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Feb 2018 09:43:18 +0100
Subject: [RFC][PATCH] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <20180226101718.5353-1-marek.vasut+renesas@gmail.com>
References: <20180226101718.5353-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdU=S2RbnzkGcyHd9iNke4tiY8D8P9XnFdSoJD5TN3oOaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Feb 26, 2018 at 11:17 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Rather than hard-coding the quirk topology, which stopped scaling,
> parse the information from DT. The code looks for all compatible
> PMICs -- da9036 and da9210 -- and checks if their IRQ line is tied
> to the same pin. If so, the code sends a matching sequence to the
> PMIC to deassert the IRQ.

Note that not all R-Car Gen2 boards have all regulators described in DT yet.
E.g. gose lacks da9210. So that has to be fixed first.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
