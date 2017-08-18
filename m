From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 18 Aug 2017 11:16:53 +0200
Subject: [PATCH v2 0/4] ARM: dts: rcar-gen2: Stop grouping clocks under a
 "clocks" subnode
Message-ID: <1503047817-29439-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

The current practice is to not group clocks under a "clocks" subnode,
but just put them together with the other on-SoC devices.

Hence this patch series implements this for the various R-Car Gen2
DTSes that still need this (r8a7792.dtsi is OK).

Changes compared to v1:
  - Rebased.

Dependencies:
  - renesas-devel-20170818-v4.13-rc5,
  - Patch series "[PATCH v2 0/5] ARM: dts: rcar-gen2: Convert to new
    CPG/MSSR bindings".

For your convenience, this series is also available in the
topic/rcar2-cpg-mssr-dt-v2 branch of my renesas-drivers git repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

Thanks for applying!

Geert Uytterhoeven (4):
  ARM: dts: r8a7790: Stop grouping clocks under a "clocks" subnode
  ARM: dts: r8a7791: Stop grouping clocks under a "clocks" subnode
  ARM: dts: r8a7793: Stop grouping clocks under a "clocks" subnode
  ARM: dts: r8a7794: Stop grouping clocks under a "clocks" subnode

 arch/arm/boot/dts/r8a7790.dtsi | 137 ++++++++++++++++++++---------------------
 arch/arm/boot/dts/r8a7791.dtsi | 137 ++++++++++++++++++++---------------------
 arch/arm/boot/dts/r8a7793.dtsi | 125 ++++++++++++++++++-------------------
 arch/arm/boot/dts/r8a7794.dtsi | 124 ++++++++++++++++++-------------------
 4 files changed, 251 insertions(+), 272 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
