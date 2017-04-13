From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Apr 2017 21:52:19 +0200
Subject: [PATCH v2 11/22] ARM: dts: koelsch: Add generic compatible string
 for I2C EEPROM
In-Reply-To: <20170413182839.25381-12-javier@osg.samsung.com>
References: <20170413182839.25381-1-javier@osg.samsung.com>
 <20170413182839.25381-12-javier@osg.samsung.com>
Message-ID: <CAMuHMdUsQP9QutaHAix+tmmofcr=xe_oKJzmeOqk1tUuZedVRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 8:28 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> The at24 driver allows to register I2C EEPROM chips using different vendor
> and devices, but the I2C subsystem does not take the vendor into account
> when matching using the I2C table since it only has device entries.
>
> But when matching using an OF table, both the vendor and device has to be
> taken into account so the driver defines only a set of compatible strings
> using the "atmel" vendor as a generic fallback for compatible I2C devices.
>
> So add this generic fallback to the device node compatible string to make
> the device to match the driver using the OF device ID table.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -702,7 +702,7 @@
>         };
>
>         eeprom at 50 {
> -               compatible = "renesas,24c02";
> +               compatible = "renesas,24c02","atmel,24c02";

Missing space after comma.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
