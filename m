From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 14 Nov 2014 16:49:45 +0100
Subject: [PATCH v4 0/2] ARM: shmobile: Add early debugging support using
 SCIF(A)
Message-ID: <1415980187-12683-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus, Arnd,

This patch series adds serial port debug macros for the SCIF(A) serial ports.
This includes all supported shmobile SoCs, except for EMEV2.

It contains 2 patches, which are two alternative versions:
  - The first patch keeps on using the identity mapping set up by .map_io()
    on platforms I cannot test myself (sh7372 and r8a7779),
  - The second one converts the remaining platforms to use debug_ll_io_init(),
    which allowed to get rid of the #ifdef in renesas-scif.S, and consolidate
    more config options.

Both versions work fine on r8a7791/koelsch (multiplatform), r8a7740/armadillo
(legacy and reference), and sh73a0/kzm9g (legacy, reference, and
multiplatform), also with a multiplatform kernel based on shmobile_defconfig.

I'd appreciate if you could test the second one on sh7372 and r8a7779,
and if it works, apply it.

Else, please apply the first version. We can do incremental conversions later,
as discussed before.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
