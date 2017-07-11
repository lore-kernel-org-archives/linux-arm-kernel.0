From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 11 Jul 2017 10:59:40 +0200
Subject: [PATCH 9/9] ARM: multi_v7_defconfig: Enable DMA for Renesas
 serial ports
In-Reply-To: <CAK8P3a3c68=L=h+nni39BmOb68wno7TuvXuBgOHrEMOrkhdx2g@mail.gmail.com>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
 <1499693302-25120-10-git-send-email-geert+renesas@glider.be>
 <CANqRtoSi8x7zqwV3Gp_n0dBe4Uw6LDRvC1Lheu+GrLZNYuxAHw@mail.gmail.com>
 <CAMuHMdXb1yAgw4AVvheYhPV=V9HeDCW2NdvhJWzoSz8i-mM3TQ@mail.gmail.com>
 <CAK8P3a3c68=L=h+nni39BmOb68wno7TuvXuBgOHrEMOrkhdx2g@mail.gmail.com>
Message-ID: <CAMuHMdUFnYSxF0grMQ6GB4h7svOeKa-SpPo_2TpTW9Hx+zvrEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jul 11, 2017 at 10:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 11, 2017 at 8:59 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Tue, Jul 11, 2017 at 5:38 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> On Mon, Jul 10, 2017 at 10:28 PM, Geert Uytterhoeven
>>> Since enabling DMA Engine still keeps PIO support around I wonder why
>>> we need this Kconfig at all - other drivers seem to get by without
>>> this kind of thing?
>>> So in my opinion it would also be nice to get rid of SERIAL_SH_SCI_DMA
>>> completely and reducing the number of special per-driver Kconfig
>>> entries.
>>
>> In general, I would agree, and remove the option at the blimp of an eye.
>> However, this driver is shared with H8/300 and SuperH.  While both could use
>> DMA (but it's not supported by Linux yet), I don't know if they are willing to
>> live with the increased static and dynamic memory footprint of SH_SCI DMA
>> support.
>
> One more thing: enabling the DMA support in the console driver generally
> means you cannot use printk in the DMA driver anywhere that may be called
> during printk(). Not sure if that is a concern here.

Not anymore, as all of these prints should have been removed/disabled already.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
