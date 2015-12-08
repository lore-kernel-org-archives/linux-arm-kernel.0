From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  8 Dec 2015 18:54:05 +0100
Subject: [PATCH 00/13] ARM: shmobile: dts: Update console parameters
Message-ID: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series updates the console parameters in the DTSes for
various Renesas ARM boards.

  - For all of them, the serial port config is added to
    chosen/stdout-path, as per current best practices,
  - On some boards (armadillo, bockw, kzm9d, kzm9g), "console="
    parameters are removed from the kernel command lines, as they're no
    longer needed for DT-only platforms,
  - On some boards (genmai, kzm9g), the console alias is changed to
    "serial0", for consistency with other boards (the first serial port
    is always called "serial0", unless labeled otherwise); this does
    mean the device changes its name to /dev/ttySC0 in userspace, which
    also happened on R-Car Gen2 before,
  - On kzm9d, a console alias is added.
	    
Tested on r8a73a4/ape6evm, r8a7740/armadillo, r8a7778/bockw,
r8a7779/marzen, r8a7791/koelsch, and sh73a0/kzm9g.

Thanks for applying!

Geert Uytterhoeven (13):
  ARM: shmobile: alt dts: Add serial port config to chosen/stdout-path
  ARM: shmobile: ape6evm dts: Add serial port config to
    chosen/stdout-path
  ARM: shmobile: armadillo800eva dts: Update console parameters
  ARM: shmobile: bockw dts: Update console parameters
  ARM: shmobile: genmai dts: Update console parameters
  ARM: shmobile: gose dts: Add serial port config to chosen/stdout-path
  ARM: shmobile: koelsch dts: Add serial port config to
    chosen/stdout-path
  ARM: shmobile: kzm9d dts: Update console parameters
  ARM: shmobile: kzm9g dts: Update console parameters
  ARM: shmobile: lager dts: Add serial port config to chosen/stdout-path
  ARM: shmobile: marzen dts: Add serial port config to
    chosen/stdout-path
  ARM: shmobile: porter dts: Add serial port config to
    chosen/stdout-path
  ARM: shmobile: silk dts: Add serial port config to chosen/stdout-path

 arch/arm/boot/dts/emev2-kzm9d.dts             | 8 ++++++--
 arch/arm/boot/dts/r7s72100-genmai.dts         | 4 ++--
 arch/arm/boot/dts/r8a73a4-ape6evm.dts         | 2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 8 ++++----
 arch/arm/boot/dts/r8a7778-bockw.dts           | 4 ++--
 arch/arm/boot/dts/r8a7779-marzen.dts          | 2 +-
 arch/arm/boot/dts/r8a7790-lager.dts           | 2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts         | 2 +-
 arch/arm/boot/dts/r8a7791-porter.dts          | 2 +-
 arch/arm/boot/dts/r8a7793-gose.dts            | 2 +-
 arch/arm/boot/dts/r8a7794-alt.dts             | 2 +-
 arch/arm/boot/dts/r8a7794-silk.dts            | 2 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts            | 8 ++++----
 13 files changed, 26 insertions(+), 22 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
