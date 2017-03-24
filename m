From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 24 Mar 2017 14:37:43 +0100
Subject: [PATCH/RFC v2 0/2] arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
Message-ID: <1490362665-4422-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series adds preliminary support for Renesas Salvator-X
development boards equipped with revision ES2.0 of the R-Car H3 Soc.

  - Patch 1 adds support for the R-Car H3 ES2.0 Soc,
    While this patch is safe as-is, as it doesn't affect any existing
    setups, it's probably a bit premature to apply it.
  - Patch 2 adds support for Salvator-X boards with R-Car H3 ES2.0.
    This patch does affect existing development setups, as it changes the
    name of the DTB for Salvator-X boards equipped with ES1.x SoCs.
    Given most developers have access to ES1.x only, this patch must not be
    applied yet.

Note that for now, it is assumed that all H3ULCB boards are equipped with
R-Car H3 ES1.x.

For changes compared to v1 (which was not posted), please refer to the
individual patches.

Dependencies:
  - renesas-devel-20170324-v4.11-rc3,
  - [PATCH v2 0/4] clk: renesas: Add support for R-Car H3 ES2.0,
  - [PATCH v2 0/4] pinctrl: sh-pfc: Add support for R-Car H3 ES2.0,
  - [PATCH 0/3] soc: renesas: rcar-sysc: Add support for R-Car H3 ES2.0.

To do:
  - Reduce duplication by sharing Salvator-X board description.

For testers, this series is available in the topic/r8a7795es2-dt-v2 branch
of my renesas-drivers git repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

An integration branch (incl. all dependencies) for testing is provided as
topic/r8a7795es2-integration.  I plan to update this branch when any of the
dependencies are updated.

This has been tested on Salvator-X with R-Car H3 ES1.0 and ES2.0 SoCs.

Thanks for your comments!

Geert Uytterhoeven (2):
  arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
  arm64: dts: r8a7795: salvator-x: Add support for R-Car H3 ES2.0

 arch/arm64/boot/dts/renesas/Makefile               |  1 +
 ...5-salvator-x.dts => r8a7795-es1-salvator-x.dts} |  4 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       | 83 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  4 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 70 +-----------------
 6 files changed, 90 insertions(+), 74 deletions(-)
 copy arch/arm64/boot/dts/renesas/{r8a7795-salvator-x.dts => r8a7795-es1-salvator-x.dts} (99%)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
