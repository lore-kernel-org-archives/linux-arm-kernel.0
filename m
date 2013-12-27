From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 27 Dec 2013 21:15:54 +0100
Subject: [PATCH v2 0/8] SoC and board integration for RSPI on RZ/A1H
Message-ID: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series integrates Renesas RSPI on the RZ/A1H aka R7S72100 SoC,
and the Genmai development board.

The series is based on renesas-devel-v3.13-rc5-20131226, with Magnus'
pinctrl, Wolfram's riic, and Simon's sh_eth work applied on top.

It was tested on the Genmai development board (genmai-reference), using
an in-kernel version of Documentation/spi/spidev_test.c, exercising
loopback mode on rspi1, with the same outcome as the SDK reference code.

Notes:
  1. The proposed DT bindings also talk about QSPI on the R8A779x, as those
     SoCs use the same driver.
  2. As the actual spi-rspi driver doesn't use DT yet, platform devices and
     spi board info are still used from C to instantiate SPI buses and their
     children, while pinctrl is performed by DT.
  3. It will not work with the non-reference version of genmai, due to
     missing pinmux configuration in setup-r7s72100.c.
  4. Patches [4/8] and [5/8] are new.

    [1/8] pinctrl: sh-pfc: r7s72100: Add RSPI support
    [2/8] ARM: shmobile: r7s72100: Add RSPI clocks
    [3/8] ARM: shmobile: r7s72100: Add RSPI platform devices
    [4/8] ARM: shmobile: genmai: Add RSPI children (NEW)
    [5/8] [RFC] ARM: shmobile: genmai: Add preliminary RSPI pinmux (NEW)
    [6/8] [RFC] Documentation: dt: Add Renesas RSPI/QSPI bindings
    [7/8] [RFC] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
    [8/8] [RFC] ARM: shmobile: genmai reference: Add RSPI nodes

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
