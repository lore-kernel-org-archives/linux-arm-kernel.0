From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Jun 2015 15:03:31 +0200
Subject: [PATCH 0/5] ARM: shmobile: R-Mobile APE6 / R-Car Gen2: Use "arm,
 gic-400"
Message-ID: <1434546216-10773-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series replaces the "arm,cortex-a15-gic" compatible value for
the GIC device node by "arm,gic-400" in the R-Mobile APE6 and R-Car Gen2
device trees:
  - The R-Mobile APE6 documentation states it has a GIC-400,
  - The R-Car Gen2 is assumed to have a GIC-400, too.

The presence of a GIC-400 has been confirmed on APE6 and R-Car M2 by
reading the GICD_IIDR register[1], which reports 0x0200043b (GIC-400 =
0x02, ARM = 0x43b).

This change has no effect on runtime behavior, as currently[2] the GIC
driver treats both compatible values the same.

This has been tested on r8a73a4/ape6evm and r8a7791/koelsch.

Thanks for applying!

[1] Using Mark Rutland's patch in https://lkml.org/lkml/2015/4/29/259,
    or from U-Boot using "md 0xf1001008 1",
[2] Backporter's note: since commit 144cb08864ed44be ("irqchip: gic: Add
    binding probe for ARM GIC400").

Geert Uytterhoeven (5):
  ARM: shmobile: r8a73a4 dtsi: Use "arm,gic-400" for GIC
  ARM: shmobile: r8a7790 dtsi: Use "arm,gic-400" for GIC
  ARM: shmobile: r8a7791 dtsi: Use "arm,gic-400" for GIC
  ARM: shmobile: r8a7793 dtsi: Use "arm,gic-400" for GIC
  ARM: shmobile: r8a7794 dtsi: Use "arm,gic-400" for GIC

 arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 arch/arm/boot/dts/r8a7793.dtsi | 2 +-
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
