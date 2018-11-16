From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 16 Nov 2018 14:48:40 +0100
Subject: [PATCH v2 0/2] arm: renesas: Move SoC Kconfig symbols to
 drivers/soc/renesas/
Message-ID: <20181116134842.26488-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

As pointed out by Arnd[*], there are lots of SoC-specific Kconfig
symbols in the Renesas section of arch/arm64/Kconfig.platforms, while
other vendors expose a single Kconfig symbol there.

Hence this patch series moves them to drivers/soc/renesas/Kconfig,
reducing the footprint and associated amount of churn in
arch/arm64/Kconfig.platforms, while preserving the benefits for users of
automatic selection of e.g. clock and pinctrl drivers.

As my OCD just loves consistency, the second patch does the same for
arm32 SoCs.

Note that e.g. drivers/clk/ is included before drivers/soc/.  Hence when
COMPILE_TEST=y and ARCH_RENESAS=n, questions will be asked about clock
drivers before they can be auto-selected by the corresponding
SoC-specific Kconfig symbols.

Of course this will trigger some defconfig updates later...

Changes compared to v1/RFC:
  - Introduce a family-specific Kconfig symbol for R-Car Gen3,
  - Move arm32 family-specific Kconfig symbols, too.

This depends on Simon's devel branch, and "ARM: shmobile: Hide ARCH_RZN1
to improve consistency".

Thanks!

[*] https://www.spinics.net/lists/arm-kernel/msg679390.html


Geert Uytterhoeven (2):
  arm64: renesas: Move SoC Kconfig symbols to drivers/soc/renesas/
  ARM: shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/

 arch/arm/mach-shmobile/Kconfig | 126 ------------------
 arch/arm64/Kconfig.platforms   |  59 ---------
 drivers/soc/renesas/Kconfig    | 236 ++++++++++++++++++++++++++++++---
 3 files changed, 215 insertions(+), 206 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
