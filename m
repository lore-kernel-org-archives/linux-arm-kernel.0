From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  7 May 2018 15:19:51 +0200
Subject: [PATCH v3 0/2] ARM: dts: renesas: Correct mask for GIC PPI interrupts
Message-ID: <1525699193-5589-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

        Hi Simon, Magnus,

R-Car H2 and R-Mobile APE6 contain four Cortex-A15 and four Cortex-A7
cores, hence the second interrupt specifier cell for Private Peripheral
Interrupts should use "GIC_CPU_MASK_SIMPLE(8)", to make sure interrupts
can be delivered to all 8 processor cores.

This brings the predecessors of R-Car Gen3 in line with what we're doing
on other big.LITTLE SoCs, like R-Car H3 and M3-W.

Changes compared to v2:
  - Change one-line summary prefix to match current arm-soc practices,
  - Fast-forward by 3 years,
  - Rebase.

Changes compared to v1:
  - Drop RFC status after receiving confirmation from Liviu Dudau.

Thanks for applying!

P.S. Feel free to take a ride on your unicorn, to test on a legendary
     system that boots all 8 cores.

Geert Uytterhoeven (2):
  ARM: dts: r8a7790: Correct mask for GIC PPI interrupts
  ARM: dts: r8a73a4: Correct mask for GIC PPI interrupts

 arch/arm/boot/dts/r8a73a4.dtsi | 10 +++++-----
 arch/arm/boot/dts/r8a7790.dtsi | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
