From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Jun 2014 15:42:04 +0200
Subject: [PATCH v2 0/7] ARM: shmobile: koelsch reference: Enable DMA for QSPI
Message-ID: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables DMA support for QSPI on r8a7791/koelsch
reference.  It's independent from the series "ARM: shmobile: koelsch
legacy: Enable DMA for QSPI", but it depends on the SHDMA work for r8a7790
by Ben Dooks (cfr. "[PATCH v2 0/9] Updates Renesas OF-DMA code").

Changes Compared to previous submission ("[PATCH/RFC 0/7] ARM: shmobile:
r8a7791: Add preliminary DMA support"):
  - "[6/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIOF" was dropped,
  - 2/7 was added,
  - 7/7 was changed (see changelog in individual patch).

This was tested on r8a7791/koelsch.

Performance figures for reading from a QSPI FLASH driven at 24.375 MHz are:
  - Single:  1.1 Mbps PIO, 23 Mbps DMA
  - Dual  : 12.7 Mbps PIO, 48 Mbps DMA
  - Quad  : 13   Mbps PIO, 70 Mbps DMA

Thanks for your comments!

  [1/7] DMA: shdma: Add r8a7791 support
  [2/7] DMA: shdma: Spelling s/controll/control/
  [3/7] ARM: shmobile: r8a7791 dtsi: add SYS-DMAC clocks
  [4/7] ARM: shmobile: r8a7791: Add SYS-DMAC channel definitions for bindings
  [5/7] ARM: shmobile: r8a7791 dtsi: Add SYS-DMAC0 and SYS-DMAC1 nodes
  [6/7] ARM: shmobile: koelsch dts: Enable sysdma0 and sysdma1
  [7/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI

 Documentation/devicetree/bindings/dma/shdma.txt |   7 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |   8 ++
 arch/arm/boot/dts/r8a7791.dtsi                  |  79 ++++++++++++++++-
 drivers/dma/sh/shdmac.c                         |   1 +
 include/dt-bindings/dma/r8a7791-dma.h           | 111 ++++++++++++++++++++++++
 5 files changed, 201 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/dma/r8a7791-dma.h

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
