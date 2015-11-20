From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Nov 2015 13:36:51 +0100
Subject: [PATCH 0/6] ARM: shmobile: Use "arm,pl390" for GIC where appropriate
Message-ID: <1448023017-21816-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus, Greg,

On several Renesas ARM SoCs, the GIC is described in DT as being a
Cortex A9 GIC, while it's actually a PL390. This is not only stated in
the documentation, but has been verified by reading the GICD_IIDR
register.

This series
  1. Corrects the DT compatible value to match reality,
  2. Updates the board staging drivers to match the above.

As both parts impact each other, I think it's best that all patches go
in through Simon's ARM/SHMOBILE tree.

Greg: can you please provide your ack for the last two patches?

Thanks!

Geert Uytterhoeven (6):
  ARM: shmobile: r7s72100 dtsi: Use "arm,pl390" for GIC
  ARM: shmobile: r8a7740 dtsi: Use "arm,pl390" for GIC
  ARM: shmobile: emev2 dtsi: Use "arm,pl390" for GIC
  ARM: shmobile: r8a7778 dtsi: Use "arm,pl390" for GIC
  staging: board: kzm9d: Use "arm,pl390"
  staging: board: armadillo800eva: Use "arm,pl390"

 arch/arm/boot/dts/emev2.dtsi            | 2 +-
 arch/arm/boot/dts/r7s72100.dtsi         | 2 +-
 arch/arm/boot/dts/r8a7740.dtsi          | 2 +-
 arch/arm/boot/dts/r8a7778.dtsi          | 2 +-
 drivers/staging/board/armadillo800eva.c | 2 +-
 drivers/staging/board/kzm9d.c           | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
