From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 14 Mar 2018 13:09:43 +0100
Subject: [PATCH v2 0/3] arm64: dts: renesas: salvator-x(s)/ulcb: Configure
 PMIC for DDR Backup Power
Message-ID: <1521029386-29975-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

The ROHM BD9571MWV PMIC on the Renesas Salvator-X(S) and ULCB
development boards supports DDR Backup Power, which means that the DDR
power rails can be kept powered while the main SoC is powered down.

This patch series is the DT counterpart of the series "[PATCH v2 0/4]
regulator: bd9571mwv: Add support for DDR backup mode" [1] and
"[PATCH/RFC 0/2] regulator: bd9571mwv: Add support for toggle power
switches" [2].

The first patch adds the missing device node for the BD9571 PMIC on the
ULCB boards, and can be applied immediately.
The last two patches add DDR Backup Mode configuration, and depend on
the DT bindings in the driver patch being accepted.

Changes compared to v2:
  - Add support for ULCB,
  - Add "rohm,rstbmode-level" for Salvator-X(S).

This has been tested on M3ULCB (thanks Jacopo!), and on Salvator-X(S).

For testing, driver and DTS patches are available in the
topic/bd9571-ddr-backup-mode-driver-v2 and
topic/bd9571-ddr-backup-mode-dt-v2 branches of my renesas-drivers git
repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

Thanks for your comments!

[1] https://lkml.org/lkml/2018/3/14/302
[2] https://lkml.org/lkml/2018/3/14/324

Geert Uytterhoeven (3):
  arm64: dts: renesas: ulcb: Add BD9571 PMIC
  arm64: dts: renesas: salvator-common: Configure PMIC for DDR Backup
    Power
  arm64: dts: renesas: ulcb: Configure PMIC for DDR Backup Power

 arch/arm64/boot/dts/renesas/salvator-common.dtsi |  2 ++
 arch/arm64/boot/dts/renesas/ulcb.dtsi            | 31 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
