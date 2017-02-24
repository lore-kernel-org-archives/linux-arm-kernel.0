From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 24 Feb 2017 14:49:12 +0100
Subject: [PATCH v2 0/2] arm64: dts: renesas: Upgrade to PSCI v1.0 to support
 Suspend-to-RAM
Message-ID: <1487944154-31435-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series upgrades the version of the PSCI firmware, as
advertised in DT on Renesas R-Car Gen3 systems, from v0.2 to v1.0.

Note that this series does not have any runtime effects: as of PSCI
v0.2, PSCI provides a VERSION API.  Hence Linux always detected the
actual version, regardless of what was stated in DT, and enabled v1.0
features like system suspend:

    PSCIv1.0 detected in firmware.

However, it is better to have the real hardware^H^H^H^H^H^H^H^Hfirmware
description in DT.

Changes compared to v1:
  - Keep "arm,psci-0.2".

Tested on Salvator-X (both H3 and M3-W) with firmware v2.16.0, but I do
have old boot logs showing that PSCIv1.0 has been detected for a long
time.

Thanks for applying!

Khiem Nguyen (2):
  arm64: dts: r8a7795: Upgrade to PSCI v1.0 to support Suspend-to-RAM
  arm64: dts: r8a7796: Upgrade to PSCI v1.0 to support Suspend-to-RAM

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
