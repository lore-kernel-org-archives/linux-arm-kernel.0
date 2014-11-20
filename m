From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 20 Nov 2014 08:56:10 +0100
Subject: [GIT PULL] Third Round of Renesas ARM Based Soc Updates for v3.19
In-Reply-To: <201411192216.27740.arnd@arndb.de>
References: <cover.1415841454.git.horms+renesas@verge.net.au>
 <201411192216.27740.arnd@arndb.de>
Message-ID: <CAMuHMdWGnx9D4BJR3C0b=iuEKP_AN+JORiOHX+c-MkqcURAjtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Nov 19, 2014 at 10:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> Geert Uytterhoeven (1):
>>       ARM: shmobile: sh73a0: Add restart callback
>
> I'm not too happy about the restart handler here:
>
> +#define RESCNT2 IOMEM(0xe6188020)
> +static void sh73a0_restart(enum reboot_mode mode, const char *cmd)
> +{
> +       /* Do soft power on reset */
> +       writel((1 << 31), RESCNT2);
> +}
>
> I see that you have the same thing in other SoCs, but I'd really want to
> see this done properly at some point and likely won't take future patches
> doing the same thing.

This is basically just moving/copying code from a board file to an SoC
file.

> Please have a look at drivers/power/restart for how other platforms do
> this. You probably need to add a device node for whatever IP block
> holds the reset register and then have a driver. What exactly this
> driver should look like depends of course on what other registers are
> part of this block.

I agree. Thanks for reminding us.

The IP block is the system-controller, which is also used for PM domain
control. So I'll take care of it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
