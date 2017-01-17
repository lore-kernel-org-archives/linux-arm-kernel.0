From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Jan 2017 13:49:16 +0100
Subject: [PATCH 0/4] ARM/arm64: dts: renesas: Link ARM GIC to clock and clock
 domain
Message-ID: <1484657360-13101-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series improves the topology description in DT of the ARM GIC
on Renesas SoCs using the CPG/MSSR bindings (R-Car Gen3 and RZ/G).
It links the GIC to its module clock, and adds it to the SYSC "always
on" PM Domain.

Note that currently the GIC-400 driver doesn't support module clocks nor
Runtime PM, so this must be handled as a critical clock.
As the CPG/MSSR driver, unlike the legacy MSTP driver, is already aware
of critical clocks, this series can be applied right now.

Thanks!

Geert Uytterhoeven (4):
  ARM: dts: r8a7743: Link ARM GIC to clock and clock domain
  ARM: dts: r8a7745: Link ARM GIC to clock and clock domain
  arm64: dts: r8a7795: Link ARM GIC to clock and clock domain
  arm64: dts: r8a7796: Link ARM GIC to clock and clock domain

 arch/arm/boot/dts/r8a7743.dtsi           | 3 +++
 arch/arm/boot/dts/r8a7745.dtsi           | 3 +++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 3 +++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +++
 4 files changed, 12 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
