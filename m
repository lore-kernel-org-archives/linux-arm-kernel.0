From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  7 Mar 2017 19:03:21 +0100
Subject: [PATCH v2 0/5] arm64: dts: r8a7796: Add Secondary CPU Cores
Message-ID: <1488909806-3322-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series adds the second Cortex-A57 CPU core, the Cortex-A57
PMU, and the Cortex-A53 L2 cache-controller, CPU, and PMU nodes on the
Renesas R-Car M3-W SoC to its DTS file.

Note that these patches add hardware description; actual enabling of the
CPU depends on the PSCI firmware.

With the current firmware version (v2.16.0), only the CA57 CPU cores are
enabled, hence the last patch does not introduce undeterministic
scheduling behavior due to migration between big and LITTLE cores.

Changes compared to v1:
  - Add Cortex-A57 and Cortex-A53 PMU nodes,
  - Drop unit address and reg property for integrated cache-controller.

Tested on r8a7796/salvator-x, with CPU hot(un)plug and system suspend.

Thanks for applying!

Geert Uytterhoeven (3):
  arm64: dts: r8a7796: Add CA53 L2 cache-controller node
  arm64: dts: r8a7796: Add Cortex-A53 CPU cores
  arm64: dts: r8a7796: Add Cortex-A53 PMU node

Takeshi Kihara (2):
  arm64: dts: r8a7796: Add Cortex-A57 CPU cores
  arm64: dts: r8a7796: Add Cortex-A57 PMU node

 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 83 +++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 6 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
