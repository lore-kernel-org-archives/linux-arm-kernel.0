From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 15 Feb 2018 11:32:46 +0100
Subject: [PATCH V2] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <20180215101944.qtiquqqhgmg3gbrt@katana>
References: <20180215100208.24646-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVO7sxRjj7h=ar+bA8B3Art=Yyyr66cRqC30pw3Zz+Vag@mail.gmail.com>
 <20180215101944.qtiquqqhgmg3gbrt@katana>
Message-ID: <CAMuHMdXxPk=78D-hFrZvsByCEqh=+JY8C0iCdDy8FzTBPxnKDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Thu, Feb 15, 2018 at 11:19 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> As the code now always sends 3 i2c msgs to all 3 possible regulators, we
>> may accidentally talk to another device at 0x70 on other boards than Stout.
>
> It sends per device, so unless there is a device named "da9210" at
> addr 0x70, nothing will happen? Am I missing something?

As soon as one of the affected devices is instantiated, it has to shut up
all devices. This is done by sending the whole da9xxx_msgs[] array,
which needs modification now we have boards with two or three devices.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
