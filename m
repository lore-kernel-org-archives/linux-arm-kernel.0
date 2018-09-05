From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Sep 2018 17:45:28 +0200
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77995-draak: Add MSIOF ch2
 pins support
In-Reply-To: <1536092527-5950-1-git-send-email-ykaneko0929@gmail.com>
References: <1536092527-5950-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <CAMuHMdVSMzf6nJW4xxWQvcwcDe0qtdR8N7Y4Oe3bYngCPEXZPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kaneko-san,

On Tue, Sep 4, 2018 at 10:22 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
>
> This patch adds support for MSIOF ch2 pinctrl to use the LVDS Control
> Connector (CN41) for the Draak board on the R8A77995 SoC.
>
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [ykaneko0929 at gmail.com: deleted the unused reference to 'msiof_ref_clk']
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Minor nit below.

> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts

> @@ -371,3 +377,10 @@
>                 };
>         };
>  };
> +
> +&msiof2 {

Please insert following alphabetical order.

> +       pinctrl-0 = <&msiof2_pins>;
> +       pinctrl-names = "default";
> +       /* In case of using this node, please enable this property */

I think this deserves some explanation about CN41.

> +       /* status = "okay"; */
> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
