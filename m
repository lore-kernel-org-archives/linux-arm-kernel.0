From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 May 2017 10:27:41 +0200
Subject: [PATCH 4/4 v2] ARM: dts: add Gemini PATA/SATA support
In-Reply-To: <20170519230600.16782-4-linus.walleij@linaro.org>
References: <20170519230600.16782-1-linus.walleij@linaro.org>
 <20170519230600.16782-4-linus.walleij@linaro.org>
Message-ID: <CACRpkdbubStWj+K0eORLXRfZCWAVHs4aC5yDaUzPCPkWLcenoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 20, 2017 at 1:06 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The NAS4229B and SQ201 Gemini systems have a PATA controller
> which is linked to a SATA bridge in the SoC. Enable both
> platforms to use the PATA/SATA devices.
>
> Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Cut the timings

(...)

> +               ata at 63400000 {
(...)
> +                       /* PIO timings assume 33 MHz bus speed */
> +                       faraday,pio-active-time = <10>, <10>, <10>, <3>, <3>;
> +                       faraday,pio-recovery-time = <10>, <3>, <1>, <3>, <1>;
(...)

OK I forgot to cut the timings on the second instance, sorry.
I have removed them now so they are not there when I send this
to the ARM SoC tree.

Yours,
Linus Walleij
