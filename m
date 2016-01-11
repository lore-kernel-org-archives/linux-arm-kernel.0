From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 11 Jan 2016 19:46:57 +0100
Subject: r8a7794/alt and CONFIG_PROVE_LOCKING=y
Message-ID: <CAMuHMdXGgbpsC+JdbGc5D0fd5YSdogpqvffPAB4PU-7H_-jM_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_PROVE_LOCKING=y, r8a7794/alt doesn't boot (no output).
Earlycon doesn't help, but DEBUG_LL=y and earlyprintk gave me:

    Error: unrecognized/unsupported machine ID (r1 = 0x18009008).

    Available machine support:

    ID (hex) NAME
    ffffffff    Generic DT based system
    ffffffff Generic R8A7794 (Flattened Device Tree)

    Please check your kernel config and/or bootloader.

I'm booting using

    tftp 41000000 alt/zImage
    tftp 40f00000 alt/r8a7794-alt.dtb
    bootz 41000000 - 40f00000

just like on r8a7791/koelsch, where CONFIG_PROVE_LOCKING does work.

If I disable CONFIG_PROVE_LOCKING (e.g. shmobile_defconfig), the same kernel
boots fine.

Anyone with a clue?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
