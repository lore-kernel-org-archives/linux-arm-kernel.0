From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Feb 2014 11:47:26 +0100
Subject: [PATCH 0/7] ARM: shmobile: r8a7790/Lager QSPI SoC/board integration
Message-ID: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

The following patch series completes r8a7790 SoC and Lager board
integration for the Renesas Quad Serial Peripheral Interface. It brings
r8a7790/Lager to the same support level as r8a7791/Koelsch, allowing access
to the Spansion s25fl512s SPI FLASH for both legacy and multi-platform
kernels.

    [1/7] pinctrl: sh-pfc: r8a7790: Add QSPI pin groups
    [2/7] ARM: shmobile: lager legacy: Add QSPI pinmux
    [3/7] ARM: shmobile: r8a7790 dtsi: Add QSPI node
    [4/7] ARM: shmobile: lager dts: Add QSPI nodes
    [5/7] ARM: shmobile: lager defconfig: Enable RSPI and MTD_M25P80
    [6/7] ARM: shmobile: lager legacy: Enable Quad SPI transfers for the SPI
	  FLASH
    [7/7] ARM: shmobile: lager dts: Enable Quad SPI transfers for the SPI
         FLASH

Please do _not_ apply patches [6/7] and [7/7] yet, as these have a runtime
dependency on Quad SPI support in the RSPI/QSPI driver, which is queued up
in the linux-spi tree for v3.15.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
