From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Jul 2013 14:29:02 +0200
Subject: [PATCH 0/4] ARM: dove: DT updates for v3.11-rc2
Message-ID: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set comprises some DT updates and cleanup patches that
piled up in the past. The first patch adds a cpu node for the
Marvell Sheeva PJ4(A) CPU found on Dove SoCs. While touching the
dtsi, also some nodes are renamed to achieve a consitent naming
scheme. The second patch adds some common pinmux settings to
the SoC's pinctrl node and moves the default pinctrl properties to
the corresponding nodes. The third patch adds a node for the
IR diode connected to a GPIO pin on SolidRun CuBox. Finally,
the last patch adds an initial DT file for the Globalscale D2Plug
which is also based on Marvell Dove SoC.

The whole patch set is based on v3.11-rc2 with DT part of
mv643xx_eth and irqchip/clocksource patches applied.

Although this patches are Marvell Dove only, the whole set is also
sent to devicetree mailing list to raise attention for potential DT
binding review.

Sebastian Hesselbarth (4):
  ARM: dove: add cpu device tree node
  ARM: dove: add common pinmux functions to DT
  ARM: dove: add GPIO IR receiver node to SolidRun CuBox
  ARM: dove: add initial DT file for Globalscale D2Plug

 arch/arm/boot/dts/Makefile        |    1 +
 arch/arm/boot/dts/dove-cubox.dts  |   30 ++---
 arch/arm/boot/dts/dove-d2plug.dts |   69 +++++++++++
 arch/arm/boot/dts/dove.dtsi       |  235 +++++++++++++++++++++++++++++++++----
 4 files changed, 295 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/boot/dts/dove-d2plug.dts

---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
-- 
1.7.10.4
