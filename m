From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  3 Mar 2017 14:18:15 +0100
Subject: [PATCH 0/2] arm64: dts: renesas: Remove unit-addresses and regs from
 integrated caches
Message-ID: <1488547097-4804-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series removes the bogus unit-addresses and reg properties
from the device nodes representing Cortex-A57/A53 cache controllers.

Note that the latter were added to remove warnings from dtc when using
W=1:

    Warning (unit_address_vs_reg): Node /cache-controller at 0 has a unit name, but no reg property

In hindsight, adding the reg properties turned out to be the wrong fix.
Indeed, the Cortex-A57/A53 cache controllers are integrated controllers,
and thus the device nodes representing them should not have
unit-addresses or reg properties.

This series does not have a runtime effect, as Linux doesn't rely much
on the properties of the cache-controller nodes.

After this patch has been accepted, I'll submit a similar series to fix
the DTS files for the Renesas arm32 SoCs.

Thanks for applying!

Geert Uytterhoeven (2):
  arm64: dts: r8a7795: Remove unit-addresses and regs from integrated
    caches
  arm64: dts: r8a7796: Remove unit-address and reg from integrated cache

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 ++----
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
