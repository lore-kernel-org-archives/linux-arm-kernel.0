From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 19 Nov 2014 16:26:58 +0100
Subject: [PATCH 0/2] ARM: shmobile: sh73a0 legacy: Add missing INTCA0 clock
Message-ID: <1416410820-30020-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series adds the missing INTCA0 clock on sh73a0 SoCs, for both
legacy/reference and multi-platform builds.

The INTCA0 clock drives the irqpin controller modules.
Before, it was assumed enabled by the bootloader or reset state.
By making it available to the driver, we make sure it gets enabled when
needed, and allow it to be managed by system or runtime PM.

The first patch can be applied now.
The second patch depends on the series "[PATCH v5 0/6] sh73a0 common clock
framework implementation".

Thanks!

Geert Uytterhoeven (2):
  ARM: shmobile: sh73a0 legacy: Add missing INTCA0 clock for irqpin
    module
  ARM: shmobile: sh73a0 dtsi: Add missing INTCA0 clock for irqpin module

 arch/arm/boot/dts/sh73a0.dtsi            | 15 +++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c    | 10 ++++++++++
 include/dt-bindings/clock/sh73a0-clock.h |  3 +++
 3 files changed, 28 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
