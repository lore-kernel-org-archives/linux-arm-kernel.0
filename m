From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  3 Apr 2017 11:45:40 +0200
Subject: [PATCH 0/3] ARM: dts: rcar-gen2: Correct parent of SSI[0-9] clocks
Message-ID: <1491212743-6911-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus, Morimoto-san,

The SSI-ALL gate clock is located in between the P clock and the
individual SSI[0-9] clocks, hence the former should be listed as their
parent.

This patch series corrects the parents in the DTSes r8a7790, r8a7791,
and r8a7793.  The DTS for r8a7794, and the CPG/MSSR-based clock drivers
for r8a7743, r8a7745, and r8a7795 already describe the correct parent.

Thanks!

Geert Uytterhoeven (3):
  ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks
  ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks
  ARM: dts: r8a7793: Correct parent of SSI[0-9] clocks

 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++--
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++--
 arch/arm/boot/dts/r8a7793.dtsi | 7 +++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
