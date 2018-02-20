From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 19:38:07 +0100
Subject: [PATCH] pinctrl: samsung: Validate alias coming from DT
In-Reply-To: <20180220181751.20826-1-krzk@kernel.org>
References: <20180220181751.20826-1-krzk@kernel.org>
Message-ID: <CAMuHMdUg-Fj5J7peAWUBc-5qnDc5RSzOg1TxURdEW4g9NrsYsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 7:17 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Driver uses alias from Device Tree as an index of pin controller data
> array.  In case of a wrong DTB or an out-of-tree DTB, the alias could be
> outside of this data array leading to out-of-bounds access.
>
> Depending on binary and memory layout, this could be handled properly
> (showing error like "samsung-pinctrl 3860000.pinctrl: driver data not
> available") or could lead to exceptions.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: <stable@vger.kernel.org>
> Fixes: 30574f0db1b1 ("pinctrl: add samsung pinctrl and gpiolib driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
