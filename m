From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Jul 2015 08:46:21 +0200
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <20150703024044.GB24695@verge.net.au>
References: <20150703024044.GB24695@verge.net.au>
Message-ID: <CAMuHMdW_JxdN9Bb3aii2rcrgS2Jbvmj3PmyDE-9LjN18rfKTTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Jul 3, 2015 at 4:40 AM, Simon Horman <horms@verge.net.au> wrote:
> I have observed what appears to be a regression while testing next-20150702
> which seems to be caused by 2951d5c031a3 ("tick: broadcast: Prevent
> livelock from event handler").
>
> The problem manifests on the emev2/kzm9d board as per the boot log below.
>
> The problem manifests when booting using the shmobile_defconfig,
> which uses multiplatform and enables all devices using DT.
>
> The problem does not appear to always manifest but anecdotally it
> seems to manifest more often of late (yes, I know that is vague).

> hctosys: unable to open rtc device (rtc0)
>
> The boot hangs here.
> The next line should be:
>
> smsc911x 20000000.ethernet eth0: SMSC911x/921x identified at 0xc8880000, IRQ: 33

As you can reproduce it, can you please try enabling lockdep debugging?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
