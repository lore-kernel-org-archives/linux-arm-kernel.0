From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 17 Feb 2017 16:30:32 +0100
Subject: [PATCH 0/3] arm64: dts: r8a7796: Add Secondary CPU Cores
Message-ID: <1487345435-1088-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series adds the second Cortex-A57 CPU core, and the
Cortex-A53 L2 cache-controller and CPU nodes on the Renesas R-Car M3-W
SoC to its DTS file.

Note that these patches add hardware description; actual enabling of the
CPU depends on the PSCI firmware.

With the current firmware version (v2.16.0), only the CA57 CPU cores are
enabled, hence the last patch does not introduce undeterministic
scheduling behavior due to migration between big and LITTLE cores.

Tested on r8a7796/salvator-x, with CPU hot(un)plug and system suspend.

Thanks for applying!

Geert Uytterhoeven (2):
  arm64: dts: r8a7796: Add CA53 L2 cache-controller node
  arm64: dts: r8a7796: Add Cortex-A53 CPU cores

Takeshi Kihara (1):
  arm64: dts: r8a7796: Add Cortex-A57 CPU cores

 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 64 +++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 6 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
