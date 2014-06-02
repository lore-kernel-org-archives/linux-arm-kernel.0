From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Jun 2014 15:40:20 +0200
Subject: [PATCH 0/4] ARM: shmobile: koelsch legacy: Enable DMA for QSPI
Message-ID: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables DMA support for QSPI on r8a7791/koelsch legacy.
It's independent from the series "ARM: shmobile: koelsch reference: Enable
DMA for QSPI".

[2/4] was written by Morimoto-san for LTSI 3.10, and forward ported by me.

This was tested on r8a7791/koelsch.

Performance figures for reading from a QSPI FLASH driven at 24.375 MHz are:
  - Single:  1.1 Mbps PIO, 23 Mbps DMA
  - Dual  : 12.7 Mbps PIO, 48 Mbps DMA
  - Quad  : 13   Mbps PIO, 70 Mbps DMA

Thanks for your comments!

  [1/4] ARM: shmobile: r8a7791: Add SYS-DMAC clocks
  [2/4] ARM: shmobile: r8a7791: Add SYS-DMAC support
  [3/4] ARM: shmobile: r8a7791: Add QSPI DMA support
  [4/4] ARM: shmobile: koelsch legacy: Enable DMA for QSPI

 arch/arm/mach-shmobile/board-koelsch.c        |  2 +
 arch/arm/mach-shmobile/clock-r8a7791.c        |  6 +-
 arch/arm/mach-shmobile/include/mach/r8a7791.h |  7 +++
 arch/arm/mach-shmobile/setup-r8a7791.c        | 82 +++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 1 deletion(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
