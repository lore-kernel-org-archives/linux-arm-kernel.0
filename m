From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 11 Oct 2018 10:55:06 +0200
Subject: [PATCH/RFC 0/2] arm: renesas: Move SoC Kconfig symbols to
 drivers/soc/renesas/
Message-ID: <20181011085508.5234-1-geert+renesas@glider.be>
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

Thanks for your comments!

[*] https://www.spinics.net/lists/arm-kernel/msg679390.html

Geert Uytterhoeven (2):
  [RFC] arm64: renesas: Move SoC Kconfig symbols to drivers/soc/renesas/
  [RFC] ARM: shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/

 arch/arm/mach-shmobile/Kconfig | 101 -----------------
 arch/arm64/Kconfig.platforms   |  54 ---------
 drivers/soc/renesas/Kconfig    | 201 +++++++++++++++++++++++++++++----
 3 files changed, 180 insertions(+), 176 deletions(-)

-- 
2.17.1
