From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 17 Feb 2014 10:23:31 +0100
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <20140217091900.GD2633@katana>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
 <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
 <20140217091900.GD2633@katana>
Message-ID: <CAMuHMdV5KNBcFh5E0bKaLNboZUbuXmMkzdYozqWLvro7Kwjhjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Feb 17, 2014 at 10:19 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> I think the tricky part is when a driver for "renesas,i2c-r8a7790" is updated
>> with a new feature for r8a7790, which doesn't necessarily exist in r8a7791.
>> Then the compatible entry above will cause breakage.
>
> If the driver is updated in that way, then it MUST introduce an r8a7791
> compatible entry and make sure the new feature is only used on r8a7790.
> Otherwise it is a bug. If this is adhered, we won't have a breakage
> because the specific entry (here r8a7791) always comes first. Or?

That will indeed prevent breakage. But in the distributed development world,
the person who modifies the driver may not be aware of the r8a7791.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
