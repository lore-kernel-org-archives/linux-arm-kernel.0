From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 May 2015 15:34:00 +0200
Subject: [PATCH] ARM: shmobile: only select sound drivers that build
In-Reply-To: <5616798.tmraH8vpuI@wuerfel>
References: <5616798.tmraH8vpuI@wuerfel>
Message-ID: <CAMuHMdWDS73aA8ottgEPYgE=FHFeOwWdEcRGEyv8LbOUU1eUgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, May 19, 2015 at 2:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> A couple of codec drivers are selected by shmobile platform code,
> but depend on I2C, which results in a build error:

> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig

> @@ -158,8 +158,8 @@ config MACH_BOCKW
>         depends on ARCH_R8A7778
>         select ARCH_REQUIRE_GPIOLIB
>         select REGULATOR_FIXED_VOLTAGE if REGULATOR
> -       select SND_SOC_AK4554 if SND_SIMPLE_CARD
> -       select SND_SOC_AK4642 if SND_SIMPLE_CARD
> +       select SND_SOC_AK4554 if SND_SIMPLE_CARD && I2C

AK4554 is not an i2c device, but a plain platform device.

> +       select SND_SOC_AK4642 if SND_SIMPLE_CARD && I2C
>         select USE_OF

The others are OK, so if you have remove AK4554, you can add my
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
