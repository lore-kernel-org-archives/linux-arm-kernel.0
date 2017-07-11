From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 11 Jul 2017 10:57:07 +0200
Subject: [PATCH 9/9] ARM: multi_v7_defconfig: Enable DMA for Renesas
 serial ports
In-Reply-To: <CAK8P3a1-yuxQ-m5h+u38TKoybfxrAF8XpwcB9xFYKePhukXaQw@mail.gmail.com>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
 <1499693302-25120-10-git-send-email-geert+renesas@glider.be>
 <CANqRtoSi8x7zqwV3Gp_n0dBe4Uw6LDRvC1Lheu+GrLZNYuxAHw@mail.gmail.com>
 <CAMuHMdXb1yAgw4AVvheYhPV=V9HeDCW2NdvhJWzoSz8i-mM3TQ@mail.gmail.com>
 <CAK8P3a1-yuxQ-m5h+u38TKoybfxrAF8XpwcB9xFYKePhukXaQw@mail.gmail.com>
Message-ID: <CAMuHMdUiXQEYroYsDAvrM_evGv0Fy-+knEoiQHdha3UExhQTEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jul 11, 2017 at 10:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 11, 2017 at 8:59 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>
>> Whether we want to hide the option (and default to y if ARCH_RENESAS, i.e.
>> ARM) is another question.  Note that that wouldn't reduce code maintainability,
>> as the #ifdefs would be kept, and it would prevent building and testing
>> with/without DMA on ARM.
>
> arch/sh/configs/sdk7786_defconfig enables it, too, so it should at least be
> a user-selectable option on SuperH if you do that.

But that can't enable DMA, as (1) the non-DT DMA configuration was removed
due to (2) being unused.

Cfr. commit 219fb0c1436e4893 ("serial: sh-sci: Remove the platform data dma
slave rx/tx channel IDs").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
