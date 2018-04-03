From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  3 Apr 2018 12:19:36 +0100
Subject: [PATCH v3 0/3] Add r8a77470/iW-RainboW-G23S single board computer
 support
Message-ID: <1522754379-64116-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, 

This series adds support for Rensas RZ/G1C (r8a77470) SoC and
RZ/G1C based iW-RainboW-G23S single board computer.

The series introduces a cpg-mssr clock/power gating module, a power/reset
controller for the SoC.

power areas for RZ/G1C are similar to RZ/G1E.

Few functionalities have currently been enabled in DTS and tested: serial
boot console.

This patch series tested against renesas-dev branch 
tag "renesas-dev-20180328-v4.16-rc7

V1-->V2
	Incorporated geert's review comments.
V2-->V3
        Incorporated simon and geert's review comments.

Biju Das (3):
  serial: sh-sci: Document r8a77470 bindings
  ARM: dts: r8a77470: Initial SoC device tree
  ARM: dts: iwg23s-sbc: Add support for iWave G23S-SBC based on RZ/G1C

 .../bindings/serial/renesas,sci-serial.txt         |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          |  35 +++++
 arch/arm/boot/dts/r8a77470.dtsi                    | 154 +++++++++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
 create mode 100644 arch/arm/boot/dts/r8a77470.dtsi

-- 
2.7.4
