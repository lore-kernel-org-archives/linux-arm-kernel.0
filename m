From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 11 May 2017 13:58:51 +0200
Subject: [PATCH v3 0/3] arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
Message-ID: <1494503934-23367-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series adds support for Renesas Salvator-X and H3ULCB
development boards equipped with revision ES2.0 of the R-Car H3 SoC.

Our goal is to have a single kernel image supporting both ES1. and ES2.0
revisions of the R-Car H3 SoC, and let r8a7795-salvator-x.dtb and
r8a7795-h3ulcb.dtb represent the latest production hardware.
As R-Car H3 ES1.x SoCs are pre-production revisions, the DTB files for
these revisions are renamed to r8a7795-es1-salvator-x.dtb resp.
r8a7795-es1-h3ulcb.dtb.

While this will cause a slight inconvenience for developers using
pre-production hardware, it will make it easier to deploy production
hardware, and phase out support for pre-production hardware later.
Note that unless you need access to new features not yet described in
DT, you can keep on using the existing DTBs on pre-production hardware.

  - Patch 1 adds support for the R-Car H3 ES2.0 Soc, by providing 2
    .dtsi files: r8a7795.dtsi (ES2.0), and r8a7795-es1.dtsi (ES1.x).
  - Patch 2 adds support for Salvator-X with R-Car H3 ES2.0 by providing
    2 .dts files: r8a7795-salvator-x.dts (ES2.0), and
    r8a7795-es1-salvator-x.dts(ES1.x),
  - Patch 3 adds support for ator-X with R-Car H3 ES2.0 by providing 2
    .dts files: r8a7795-salvator-x.dts (ES2.0), and
    r8a7795-es1-salvator-x.dts(ES1.x).

While patch 1 has no user-visible impact, patches 2 and 3 do.

Changes compared to v2:
  - Rebase on top of common Salvator-X board support extraction,
  - Remove the "compatible" property from the DU node in r8a7795.dtsi,
    in addition to the "vsps" property,
  - Add support for ES2.0-based H3ULCB.

For changes compared to v1 (which was not posted), please refer to the
individual patches.

Dependencies:
  - This patch series is against renesas-devel-20170503-v4.11.
    I expect a sync with other pending patches will be needed after the
    release of v4.12-rc1.
  - For proper operation, this depends on driver (clk, pfc, sysc)
    support that will be available in v4.12-rc1.

This series is available in the topic/r8a7795es2-dt-v3 branch of my
renesas-drivers git repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
An integration branch (incl. all dependencies) for testing is provided
as topic/r8a7795es2-integration.  I plan to update this branch when any
of the dependencies are updated.

This has been tested on Salvator-X (H3 ES1.0 and ES2.0), and H3ULCB with
H3 ES1.1.
This has not been tested on H3ULCB with H3 ES2.0 due to lack of
hardware.

Thanks!

Geert Uytterhoeven (3):
  arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
  arm64: dts: r8a7795: salvator-x: Add support for R-Car H3 ES2.0
  arm64: dts: r8a7795: h3ulcb: Add support for R-Car H3 ES2.0

 arch/arm64/boot/dts/renesas/Makefile               |  1 +
 .../{r8a7795-h3ulcb.dts => r8a7795-es1-h3ulcb.dts} |  4 +-
 ...5-salvator-x.dts => r8a7795-es1-salvator-x.dts} |  4 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       | 84 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 71 +-----------------
 7 files changed, 92 insertions(+), 76 deletions(-)
 copy arch/arm64/boot/dts/renesas/{r8a7795-h3ulcb.dts => r8a7795-es1-h3ulcb.dts} (91%)
 copy arch/arm64/boot/dts/renesas/{r8a7795-salvator-x.dts => r8a7795-es1-salvator-x.dts} (92%)
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
