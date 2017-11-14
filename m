From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 14 Nov 2017 09:44:54 +0100
Subject: [PATCH 3/3] arm64: dts: renesas: eagle: add EtherAVB pins
In-Reply-To: <20171110200714.406365231@cogentembedded.com>
References: <20171110200714.406365231@cogentembedded.com>
Message-ID: <CAMuHMdWCj=CjA_zyC1GKr=KEk2CNMAtwvREw25R1uJktZucY4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Nov 10, 2017 at 9:02 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the (previously omitted) EtherAVB pin data to the Eagle board's
> device tree.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for your patch!

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> @@ -34,6 +34,9 @@
>  };
>
>  &avb {
> +       pinctrl-0 = <&avb_pins>;
> +       pinctrl-names = "default";
> +
>         renesas,no-ether-link;
>         phy-handle = <&phy0>;
>         status = "okay";
> @@ -53,6 +56,11 @@
>  };
>
>  &pfc {
> +       avb_pins: avb {
> +               groups = "avb0_mdio", "avb0_mii";

Oh no, its'called "avb0_mdio" here, but "avb(0)_mdc" on all other
R-Car Gen3 SoCs?

What about "avb0_link", which is connected through "L_LNK"?

> +               function = "avb0";
> +       };
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
