From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 Aug 2017 16:11:33 +0200
Subject: [PATCH 1/2] ARM: dts: iwg20d-q7: Add RTC support
In-Reply-To: <1502197465-61546-2-git-send-email-biju.das@bp.renesas.com>
References: <1502197465-61546-1-git-send-email-biju.das@bp.renesas.com>
 <1502197465-61546-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <CAMuHMdUU5fb6G7Wc9ZzfFhLxcUuZFakPdVGh3q_cfUzxZ1AarA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 8, 2017 at 3:04 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> Define the iWave RainboW-G20D-Qseven board dependent part of the
> RTC device node.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

> @@ -54,3 +59,16 @@
>                 micrel,led-mode = <1>;
>         };
>  };
> +
> +&i2c2 {
> +       pinctrl-0 = <&i2c2_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +       clock-frequency = <400000>;
> +
> +       rtc at 68 {
> +               compatible = "bq32000";

"ti,bq32000"

> +               reg = <0x68>;
> +       };
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
