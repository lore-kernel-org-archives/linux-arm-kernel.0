From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 12 Jul 2017 13:52:49 +0200
Subject: [PATCH 3/3] ARM: dts: iwg20m: Add MMCIF0 support
In-Reply-To: <1499853805-5915-4-git-send-email-chris.paterson2@renesas.com>
References: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
 <1499853805-5915-4-git-send-email-chris.paterson2@renesas.com>
Message-ID: <CAMuHMdXMFkXopGiLOVf0jDDQTKig-wFrgMOKrf14341h85kPNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Wed, Jul 12, 2017 at 12:03 PM, Chris Paterson
<chris.paterson2@renesas.com> wrote:
> Define the iwg20m board dependent part of the MMCIF0 device node.
>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
>
> diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> index 001ca91..ffce1b6 100644
> --- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> +++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi

> +&pfc {
> +       mmcif0_pins: mmc {
> +               groups = "mmc_data8", "mmc_ctrl";

"mmc_data8" is not correct, as D6/D7 of the eMMC are not connected to GP6_28
resp. GP6_29, but to GP6_6 resp. GP6_7.
So it should be "mmc_data8_b".

Unfortunately the latter pin group isn't supported by the PFC driver yet.
Cooking a patch...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
