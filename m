From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 11:17:17 +0100
Subject: [PATCH v4 0/9] ARM/arm64: dts: rcar: Enable SCIF_CLK frequency and
 pins
Message-ID: <1454062646-4826-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series adds support for the external crystal feeding SCIF_CLK
to (H)SCIF on the various Renesas R-Car Gen1, Gen2, and Gen3 development
boards.  This increases the range and accuracy of supported baud rates.
Support for this has been accepted in the driver in v4.5-rc1.

Changes compared to v3:
  - Change one-line summary prefix to match current arm-soc practices,
  - Tested on r8a7794/alt,
  - Rebased,

Changes compared to v2:
  - Add support for r8a7778/bockw, r8a7779/marzen, r8a7790/lager,
    r8a7791/porter, r8a7793/gose, r8a7794/alt, and r8a7794/silk,
  - Add Reviewed-by.

Testing:
  - This was tested locally on r8a7791/koelsch and r8a7795/salvator-x,
  - This was tested remotely on r8a7778/bockw, r8a7779/marzen, and
    r8a7794/alt,
  - This has been in renesas-drivers for a while, so I assume it has
    received basic testing on other boards,
  - Hints for various levels of testing:
      - Change the "dev_dbg" after "done:" in
	drivers/tty/serial/sh-sci.c to "dev_info" to print clock and bit
	rate,
      - "yes U | tr -d '\n' > /dev/ttySCx" outputs a square wave with a
        frequency of half the bit rate on TXD,
      - Modifying the frequency of SCIF_CLK causes garbage on the serial
        console, unless you compensate by changing the bit rate in
        /chosen/stdout-path,
      - If you disable the SCIF_CLK, the brg_int clock will be used. If
        you change that clock, you'll get garbage again.

Dependencies:
  - renesas-devel-20160129-v4.5-rc1,
  - series "[PATCH v4 0/7] ARM: dts: R-Car: Add SCIF fallback
    compatibility strings",
  - series "[PATCH v4 00/11] ARM: dts: shmobile: Rename the serial port
    clock to fck",
  - series "[PATCH v4 0/7] ARM: dts: r-car: Add BRG support for
    (H)SCIF".

Thanks for applying!

Geert Uytterhoeven (9):
  ARM: dts: alt: Enable SCIF_CLK frequency and pins
  ARM: dts: bockw: Enable SCIF_CLK frequency and pins
  ARM: dts: gose: Enable SCIF_CLK frequency and pins
  ARM: dts: koelsch: Enable SCIF_CLK frequency and pins
  ARM: dts: lager: Enable SCIF_CLK frequency and pins
  ARM: dts: marzen: Enable SCIF_CLK frequency and pins
  ARM: dts: porter: Enable SCIF_CLK frequency and pins
  ARM: dts: silk: Enable SCIF_CLK frequency and pins
  arm64: dts: salvator-x: Enable SCIF_CLK frequency and pins

 arch/arm/boot/dts/r8a7778-bockw.dts                | 13 +++++++++++++
 arch/arm/boot/dts/r8a7779-marzen.dts               | 13 +++++++++++++
 arch/arm/boot/dts/r8a7790-lager.dts                | 13 +++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts              | 13 +++++++++++++
 arch/arm/boot/dts/r8a7791-porter.dts               | 13 +++++++++++++
 arch/arm/boot/dts/r8a7793-gose.dts                 | 13 +++++++++++++
 arch/arm/boot/dts/r8a7794-alt.dts                  | 13 +++++++++++++
 arch/arm/boot/dts/r8a7794-silk.dts                 | 13 +++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 9 files changed, 116 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
