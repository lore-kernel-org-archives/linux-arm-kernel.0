From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 16:42:21 +0100
Subject: [PATCH 0/2] arm64: dts: r8a77965: salvator-x(s): Enable s2ram and PMIC
Message-ID: <1519659743-27027-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch populates the placeholders in the R-Car M3-N DTS file for the
IIC Bus Interface for DVFS (IIC for DVFS) and Interrupt Controller for
External Devices (INTC-EX) device nodes.

After applying the first patch, you can start using s2ram (PSCI
suspend), like on other Salvator-X(S) boards
(https://elinux.org/R-Car/Boards/Salvator-XS#PSCI_System_Suspend).

The second patch enables dependencies for the BD9571MWV PMIC device,
which is described in salvator-common.dtsi. Note that operation still
depends on "[PATCH] pinctrl: sh-pfc: r8a77965: Add support for INTC-EX
IRQ pins".

Thanks!

Geert Uytterhoeven (2):
  arm64: dts: r8a77965: Add IIC-DVFS device node
  arm64: dts: r8a77965: Add INTC-EX device node

 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
