From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  6 Mar 2017 17:40:35 +0100
Subject: [PATCH 0/8] ARM: dts: renesas: Remove unit-addresses and regs from
 integrated caches
Message-ID: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series removes the bogus unit-addresses and reg properties
from the device nodes representing Cortex-A15/A7 cache controllers.

Note that the latter were added to remove warnings from dtc when using
W=1:

    Warning (unit_address_vs_reg): Node /cache-controller at 0 has a unit name, but no reg property

In hindsight, adding the reg properties turned out to be the wrong fix.
Indeed, the Cortex-A15/A7 cache controllers are integrated controllers,
and thus the device nodes representing them should not have
unit-addresses or reg properties.

This series does not have a runtime effect, as Linux doesn't rely much
on the properties of the cache-controller nodes.

This series is the arm32 counterpart of "[PATCH 0/2] arm64: dts: renesas:
Remove unit-addresses and regs from integrated caches", which you've just
applied.

Thanks for applying!

Geert Uytterhoeven (8):
  ARM: dts: r8a73a4: Remove unit-addresses and regs from integrated
    caches
  ARM: dts: r8a7743: Remove unit-address and reg from integrated cache
  ARM: dts: r8a7745: Remove unit-address and reg from integrated cache
  ARM: dts: r8a7790: Remove unit-addresses and regs from integrated
    caches
  ARM: dts: r8a7791: Remove unit-address and reg from integrated cache
  ARM: dts: r8a7792: Remove unit-address and reg from integrated cache
  ARM: dts: r8a7793: Remove unit-address and reg from integrated cache
  ARM: dts: r8a7794: Remove unit-address and reg from integrated cache

 arch/arm/boot/dts/r8a73a4.dtsi | 6 ++----
 arch/arm/boot/dts/r8a7743.dtsi | 3 +--
 arch/arm/boot/dts/r8a7745.dtsi | 3 +--
 arch/arm/boot/dts/r8a7790.dtsi | 6 ++----
 arch/arm/boot/dts/r8a7791.dtsi | 3 +--
 arch/arm/boot/dts/r8a7792.dtsi | 3 +--
 arch/arm/boot/dts/r8a7793.dtsi | 3 +--
 arch/arm/boot/dts/r8a7794.dtsi | 3 +--
 8 files changed, 10 insertions(+), 20 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
