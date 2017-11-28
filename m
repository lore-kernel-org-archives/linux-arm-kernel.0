From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Nov 2017 14:47:24 +0100
Subject: [PATCH v4 00/12] ARM: dts: renesas: Update DTS for CMT DT binding
 rework
Message-ID: <1511876856-9495-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series updates the CMT device nodes in the various Renesas DTS
files sh_cmt clocksource driver for the recent DT binding rework that was
merged in v4.14-rc1 and v4.15-rc1.

This series is an evolutionary improvement of Magnus Damm's series "[PATCH
v2 00/11] clocksource: sh_cmt: DT binding rework V2":

  - Patches 1-5 update the compatible values for the CMT0 and CMT1 device
    nodes on R-Mobile APE6 and R-Car Gen2,
  - Patches 6-12 remove the now obsolete "renesas,channels-mask" properties
    from the CMT device nodes on all affected SoCs.

Changes compared to v3:
  - Rebase against renesas-devel-20171127-v4.15-rc1,

Changes compared to v2:
  - Take over from Magnus,
  - Update compatible values,
  - Split in per-SoC patches,

Dependencies:
  - "[PATCH v3 0/7] clocksource: sh_cmt: Update driver for DT binding
    rework" was merged in v4.15-rc1.

This has been part of renesas-drivers for more than two months, and part
of my local development tree for more than two years.

Thanks for applying!

Magnus Damm (12):
  ARM: dts: r8a73a4: Update CMT compat string
  ARM: dts: r8a7790: Update CMT compat strings
  ARM: dts: r8a7791: Update CMT compat strings
  ARM: dts: r8a7793: Update CMT compat strings
  ARM: dts: r8a7794: Update CMT compat strings
  ARM: dts: r8a73a4: Remove CMT renesas,channels-mask
  ARM: dts: r8a7740: Remove CMT renesas,channels-mask
  ARM: dts: r8a7790: Remove CMT renesas,channels-mask
  ARM: dts: r8a7791: Remove CMT renesas,channels-mask
  ARM: dts: r8a7793: Remove CMT renesas,channels-mask
  ARM: dts: r8a7794: Remove CMT renesas,channels-mask
  ARM: dts: sh73a0: Remove CMT renesas,channels-mask

 arch/arm/boot/dts/r8a73a4.dtsi | 5 +----
 arch/arm/boot/dts/r8a7740.dtsi | 3 ---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++------
 arch/arm/boot/dts/r8a7791.dtsi | 8 ++------
 arch/arm/boot/dts/r8a7793.dtsi | 8 ++------
 arch/arm/boot/dts/r8a7794.dtsi | 8 ++------
 arch/arm/boot/dts/sh73a0.dtsi  | 3 ---
 7 files changed, 9 insertions(+), 34 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
